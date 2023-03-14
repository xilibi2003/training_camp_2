// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract testPayable {
    address payable public owner;
    mapping(address => uint) public deposits;
    uint called;

    constructor() payable {
        owner = payable(msg.sender);
    }

    function deposit() public payable {
      deposits[msg.sender] += msg.value;
    }

    receive() external payable {
      deposits[msg.sender] += msg.value;
    }

    // 之前是function() public
    fallback() external payable {
      deposits[msg.sender] += msg.value;
      called += 1;
    }

    function notDeposit() public {
        // deposits[msg.sender] += msg.value;
    }

    function withdrawAll() public {
        uint amount = address(this).balance;

        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    // donot use this code
    function withdraw() public {
        (bool success, ) = msg.sender.call{value: deposits[msg.sender]}("");
        deposits[msg.sender] = 0;

        require(success, "Failed to send Ether");
    }
}
