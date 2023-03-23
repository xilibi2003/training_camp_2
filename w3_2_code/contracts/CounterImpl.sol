pragma solidity ^0.8.0;


library StorageSlot {
    struct AddressSlot {
        address value;
    }

    function getAddressSlot(
        bytes32 slot
    ) internal pure returns (AddressSlot storage r) {
        assembly {
            r.slot := slot
        }
    }
}

contract Counter {
    uint private counter;

    function add(uint256 i) public {
        counter += 1;
    }

    function get() public view returns(uint) {
        return counter;
    }
}

contract CounterV2 {
    uint private counter;

    function add(uint256 i) public {
        counter += i;
    }

    function get() public view returns(uint) {
        return counter;
    }
}

contract CounterProxy  {
    bytes32 private constant IMPLEMENTATION_SLOT =
        bytes32(uint(keccak256("eip1967.proxy.implementation")) - 1);
    uint public counter;

    constructor() {
    }


    // 代理到 Counter
    function delegateAdd(uint256 n) external {
        bytes memory callData = abi.encodeWithSignature("add(uint256)", n);
        (bool ok,) = _getImplementation().delegatecall(callData);
        if(!ok) revert("Delegate call failed");
    }

    function delegateGet() external returns(uint256) {
        bytes memory callData = abi.encodeWithSignature("get()");
        (bool ok, bytes memory retVal) = _getImplementation().delegatecall(callData);

        if(!ok) revert("Delegate call failed");

        return abi.decode(retVal, (uint256));
    }


    function _getImplementation() private view returns (address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

    function _setImplementation(address _implementation) private {
        require(_implementation.code.length > 0, "implementation is not contract");
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _implementation;
    }

    function upgradeTo(address _implementation) external {
        _setImplementation(_implementation);
    }

}