pragma solidity ^0.8.0;



interface ICounter {
    function increaseCount(uint x) external;
    function lastExecuted() external view returns(uint);
}

contract CounterResolver {
    ICounter public immutable counter;

    constructor(ICounter _counter) {
        counter = _counter;
    }

    function checker()
        external
        view
        returns (bool canExec, bytes memory execPayload)
    {
        uint256 lastExecuted = counter.lastExecuted();

        canExec = (block.timestamp - lastExecuted) > 180;

        execPayload = abi.encodeCall(ICounter.increaseCount, (1));
    }
}