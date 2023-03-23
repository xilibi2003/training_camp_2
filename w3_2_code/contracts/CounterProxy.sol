//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Counter {
    uint private counter;

    function add(uint256 i) public {
        counter += 1;
    }

    function get() public view returns(uint) {
        return counter;
    }
}

contract CounterProxy  {
    address public impl;
    uint public counter;

    constructor() {
    }

    function upgradeTo(address _impl) public {
        impl = _impl;
    }

    // 分别代理到 Counter
    function delegateAdd(uint256 n) external {
        bytes memory callData = abi.encodeWithSignature("add(uint256)", n);
        (bool ok,) = address(impl).delegatecall(callData);
        if(!ok) revert("Delegate call failed");
    }

    function delegateGet() external returns(uint256) {
        bytes memory callData = abi.encodeWithSignature("get()");
        (bool ok, bytes memory retVal) = address(impl).delegatecall(callData);

        if(!ok) revert("Delegate call failed");

        return abi.decode(retVal, (uint256));
    }

}