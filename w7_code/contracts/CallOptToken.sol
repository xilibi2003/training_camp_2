//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";



// ETH Call Option
contract CallOptToken is ERC20, Ownable {
  using SafeERC20 for IERC20;


  address public udscToken;
  uint public settlementTime;
  uint public constant during = 1 days; // 1 day
  uint price;
  
  constructor(address usdc) ERC20("CallOptToken", "COPT") {
    udscToken = usdc;
    price = 5000;  
    settlementTime = block.timestamp + 100 days;
  }

  // 10 eth : 10^18; = 10^18 COPT
  // 10 COPT
  function mint() external payable onlyOwner {
    _mint(msg.sender,  msg.value);
  }

  // 10 COPT - USDT/ETH  PAIR v2 v3 
  // 1 COPT = 10 USDT 

  // amount: 0.5 COPT -> 0.5 ETH
  // usdc.approve(, needUsdcAmount); // 2612
  function settlement(uint amount) external {
    // 10.1 - 10.2
    require(block.timestamp >= settlementTime && block.timestamp < settlementTime + during, "invalid time");

    _burn(msg.sender, amount);

    uint needUsdcAmount = price * amount; // 5000 * 0.5 * 10 ^18;


    // 行权资金
    IERC20(udscToken).safeTransferFrom(msg.sender, address(this), needUsdcAmount);
    // 
    safeTransferETH(msg.sender, amount);
    // msg.sender.transfer(amount);  // 2300
  }

  // Uniswap
  function safeTransferETH(address to, uint256 value) internal {
    (bool success, ) = to.call{value: value}(new bytes(0));
    require(success, 'TransferHelper::safeTransferETH: ETH transfer failed');
  }

  function burnAll() external onlyOwner {
    require(block.timestamp >= settlementTime + during, "not end");
    uint usdcAmount = IERC20(udscToken).balanceOf(address(this));
    IERC20(udscToken).safeTransfer(msg.sender, usdcAmount);


    selfdestruct(payable(msg.sender));
    // uint ethAmount = address(this).balance;
    // safeTransferETH(msg.sender, ethAmount);
  }


}