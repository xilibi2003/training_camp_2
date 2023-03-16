pragma solidity ^0.8.0;

contract Foo {
    error nonZero();
    

    function myFunc(uint x) public pure returns (uint ) {
        // require(x != 0, "require failed");
        if (x == 0) revert nonZero();

        return x + 1;
    }
}

contract trycatch {

    Foo public foo;
    uint public y; 

    string public errMsg;
    bytes public errBytes;

    constructor() {
        foo = new Foo();
    }

    function tryCatchExternalCall(uint _i) public {
        
        try foo.myFunc(_i) returns (uint result) {
            y = result;
        } catch Error(string memory reason) { //  catch revert 
            errMsg = reason;
        } catch (bytes memory reason) {  // catch 
            errBytes = reason;
        }
    }
}