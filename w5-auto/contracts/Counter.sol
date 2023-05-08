// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Counter {
    uint public counter;
    uint public lastExecuted;

    constructor() {
    }

    function count() public {
        counter = counter + 1;

    }

    function increaseCount(uint x) public {
        counter = counter + x;
        lastExecuted = block.timestamp;
    }

}