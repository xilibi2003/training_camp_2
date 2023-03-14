pragma solidity ^0.8.0;

contract Counter {
    uint public counter;
    address public sender;

    function count() public {
        counter += 1;
        sender = msg.sender;
    }

    event logdata(uint x);

    receive() external payable {
        emit logdata(msg.value);
    }

    fallback() external {
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract CallTest {
    uint public counter;
    address public sender;

    function callCount(Counter c) public {
        c.count();
    }

    // 只是调用代码，合约环境还是当前合约。
    function lowDelegatecallCount(address addr) public {
        bytes memory methodData = abi.encodeWithSignature("count()");
        addr.delegatecall(methodData);
    }

    function lowCallCount(address addr) public {
        bytes memory methodData =abi.encodeWithSignature("count()");
        addr.call(methodData);
        // addr.call{gas:1000}(methodData);
        // addr.call{gas:1000, value: 1 ether}(methodData);
    }

}