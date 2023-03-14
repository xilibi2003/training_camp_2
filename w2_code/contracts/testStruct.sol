pragma solidity ^0.8.0;

contract testStruct {

    struct Funder {
        address addr;
        uint amount;
    }

    mapping (uint => Funder) funders;

    function contribute(uint id) public payable {
        funders[id] = Funder({addr: msg.sender, amount: msg.value});
        funders[id] = Funder(msg.sender, msg.value);
    }

    function getFund(uint id) public view returns  (address, uint ) {
        return (funders[id].addr, funders[id].amount);
    }

}
