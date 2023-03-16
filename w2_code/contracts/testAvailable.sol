pragma solidity >=0.8.0;


contract Avaiable {
    function cal(uint a) public pure returns (uint b) {
        return a + 1;
    }
    
    function setData(uint a) internal { data = a; }
    
    uint public data;

}