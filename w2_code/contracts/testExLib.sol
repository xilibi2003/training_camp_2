
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library ExLib {

    function add(uint x, uint y) external returns (uint) {
        uint z = x + y;
        require(z >= x, "uint overflow");
        return z;
    }
}

contract TestExLib {
    uint z ;
    using ExLib for uint;

    function testAdd(uint x, uint y) public returns (uint) {
        z= x.add(y);
    }

}