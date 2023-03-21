// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "./BaseScript.s.sol";
import "../src/MyERC20.sol";

contract CounterScript is BaseScript {
    function run() public broadcaster {
        MyERC20 token = new MyERC20();

        console.log("MyERC20 deployed on %s", address(token));
    }
}
