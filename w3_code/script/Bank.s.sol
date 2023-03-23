// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "./BaseScript.s.sol";
import "../src/Bank.sol";

contract BankScript is BaseScript {
    function run() public broadcaster {
        Bank bank = new Bank(0x5FbDB2315678afecb367f032d93F642f64180aa3);

        console.log("Bank deployed on %s", address(bank));
    }
}
