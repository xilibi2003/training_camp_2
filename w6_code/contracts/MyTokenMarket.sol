//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./IUniswapV2Router01.sol";
import "./IMasterChef.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract MyTokenMarket {
    using SafeERC20 for IERC20;

    address public myToken;
    address public router;
    address public weth;
    address public sushi;

    address public masterchef;
    uint public depsited;

    constructor(address _token, address _router, address _weth, address _sushi, address _masterchef) {
        myToken = _token;
        router = _router;
        weth = _weth;
        sushi = _sushi;
        masterchef = _masterchef;
    }

    // 添加流动性
    function AddLiquidity(uint tokenAmount) public payable {
        IERC20(myToken).safeTransferFrom(msg.sender, address(this),tokenAmount);
        IERC20(myToken).safeApprove(router, tokenAmount);

        // ingnore slippage
        // (uint amountToken, uint amountETH, uint liquidity) = 
        IUniswapV2Router01(router).addLiquidityETH{value: msg.value}(myToken, tokenAmount, 0, 0, msg.sender, block.timestamp);

        //TODO: handle left
    }

    // 用 ETH 购买 Token
    function buyToken(uint minTokenAmount) public payable {
        address[] memory path = new address[](2);
        path[0] = weth;
        path[1] = myToken;

        IUniswapV2Router01(router).swapExactETHForTokens{value : msg.value}(minTokenAmount, path, address(this), block.timestamp);

        uint amount = IERC20(myToken).balanceOf(address(this));

        IERC20(myToken).safeApprove(masterchef, amount);

        IMasterChef(masterchef).deposit(0, amount);
        depsited += amount;

    }

    function withdraw() public {
        IMasterChef(masterchef).withdraw(0, depsited);
        IERC20(myToken).safeTransfer(msg.sender, depsited);

        uint amount = IERC20(sushi).balanceOf(address(this));
        IERC20(sushi).safeTransfer(msg.sender, amount);

    }


}