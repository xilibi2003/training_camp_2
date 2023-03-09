// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "./BaseScript.s.sol";
import "../src/Counter.sol";

contract CounterScript is BaseScript {
    function run() public broadcaster {
        Counter c = new Counter();

        console.log("Counter deployed on %s", address(c));
        saveContract("local","Counter" , address(c));
    }
}
