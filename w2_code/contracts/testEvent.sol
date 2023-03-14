
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract testEvent {

    constructor() {
    }

    event Deposit(address indexed _from, uint _value);

    function deposit(uint value) public {
        emit Deposit(msg.sender, value);
    }
}