
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Multicall.sol";

contract MultiCallCounter is Multicall {
    uint public counter;

    function add(uint256 i) public {
        counter += i;
    }
}