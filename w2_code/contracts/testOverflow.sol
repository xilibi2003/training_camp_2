// pragma solidity ^0.5.0;
pragma solidity ^0.8.0;

contract testOverflow {
    function add1() public pure returns (uint8) {
        uint8 x = 128;
        uint8 y = x * 2;
        return y;
    }

    function add2() public pure returns (uint8) {
        uint8 i = 240;
        uint8 j = 16;
        uint8 k = i + j;
        return k;
    }


    function sub1() public pure returns (uint8) {
        uint8 m = 1;
        uint8 n = m - 2;
        return n;
    }
}
