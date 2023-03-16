pragma solidity ^0.8.0;

abstract contract A {
    uint public a;
    function add(uint x) public virtual;
}

contract B is A {
    uint public b ;
    constructor() {
        b = 2;
    }

    function add(uint x) public override virtual  {
        b += x;
    }
}