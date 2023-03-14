pragma solidity ^0.8.0;

contract Called{
    event logdata(uint x);
    uint total;

    // 这是一个回退函数, 收到以太币会被调用
    receive() external payable {
        emit logdata(msg.value);
        // 
        total += msg.value;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}

contract CallTest{

    constructor() payable {
    }

    function transferEther(address towho) public returns (bool) {
        payable(towho).transfer(1 ether);
        return true;
    }

    function saveTransferEth(address addr ) public {
        (bool success, ) = addr.call{value: 1 ether}(new bytes(0));
        require(success, 'safeTransferETH: ETH transfer failed');
    }

}