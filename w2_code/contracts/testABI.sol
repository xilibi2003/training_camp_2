//  SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {

  uint public counter;

  constructor() {
      counter = 0;
  }

  // "0x06661abd"
  function count() public {
      counter = counter + 1;
  }
}

contract testAbi {
  function call(address counter, bytes memory payload) public {
    (bool success, ) = counter.call(payload);
    require(success, "failed");
  }
}