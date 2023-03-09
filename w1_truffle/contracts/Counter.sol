// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Counter {
    uint public counter;

    constructor() {
        counter = 1;
    }

    function count() public {
        counter = counter + 1;
    }

}