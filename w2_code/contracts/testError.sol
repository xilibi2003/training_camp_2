pragma solidity ^0.8.0;

contract testError {

    address owner;

    error NotOwner();

    constructor() {
        owner = msg.sender;
    }

    function doSomething() public {
        if(msg.sender != owner) revert NotOwner();

        // require(msg.sender == owner, "Not owner");
    }
}