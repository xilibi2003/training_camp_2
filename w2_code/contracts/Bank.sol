pragma solidity ^0.8.0;

contract Bank {

    address public owner;
    mapping(address => uint) public deposits;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    receive() external payable {
        deposits[msg.sender] += msg.value;
    }

    function myDeposited() public view returns(uint) {
        return deposits[msg.sender];
    }

    function withdraw() public {
        (bool success, ) = msg.sender.call{value: deposits[msg.sender]}(new bytes(0));
        require(success, 'ETH transfer failed');

        deposits[msg.sender] = 0;
    }

    function  withdrawAll() public onlyOwner {
        uint b = address(this).balance;
        payable(owner).transfer(b);
    }

}