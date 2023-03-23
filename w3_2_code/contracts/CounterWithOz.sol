pragma solidity ^0.8.0;


import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract CounterWithOz is Initializable {
    uint private counter;

    function initialize(uint256 _x) public initializer {
        counter = _x;
    }

    function add(uint256 i) public {
        counter += 1;
    }

    function get() public view returns(uint) {
        return counter;
    }
}