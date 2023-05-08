//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract USDC is ERC20 {
  constructor() ERC20("USDC", "USDC") {
    _mint(msg.sender, 10000000e18);
  }
}