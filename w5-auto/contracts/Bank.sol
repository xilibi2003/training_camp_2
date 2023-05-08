pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/extensions/draft-IERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


contract Bank {
    mapping(address => uint) public deposited;
    address public immutable token;
    address owner;


    constructor(address _token) {
        token = _token;
        owner = msg.sender;
    }


    function deposit(address user, uint amount) public {
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "Transfer from error");
        deposited[user] += amount;
    }


    function permitDeposit(address user, uint amount, uint deadline, uint8 v, bytes32 r, bytes32 s) external {
        IERC20Permit(token).permit(msg.sender, address(this), amount, deadline, v, r, s);
        deposit(user, amount);
    }

    function withdraw() external {
        uint amount = deposited[msg.sender];
        SafeERC20.safeTransfer(IERC20(token), msg.sender, amount);
        deposited[msg.sender] = 0;
    }


    function collect() external {
        if(IERC20(token).balanceOf(address(this) )> 5e18) {
            SafeERC20.safeTransfer(IERC20(token), owner, 5e18);    
        }
    }

}

