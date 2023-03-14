pragma solidity ^0.8.0;

contract testArray {
    // storage 位置
    uint[10] tens; 
    uint[] public numbers;

    function modifyOnTens(uint x) public {
        tens[0] = x;
        // tens.push(x);
	}

    function add(uint x) public {
        numbers.push(x);
	}

    function copy(uint[] calldata arrs) public returns (uint len) {
        numbers = arrs;
        return numbers.length;
    }

    function modityNumbers() public {
        uint[] storage y = numbers;  // 不赋值，指向同一个数据
        y[0] = 1;
    }

	function test(uint len) public {
        uint x;
        // 内存 位置
        string[4] memory adaArr = ["This", "is", "an", "array"];
        uint[] memory c = new uint[](len);
        
	}

    // gas issue
    function dosome() public {
        uint len = numbers.length;
        for (uint i = 0; i < len; i++) {
            // do...
        }
    }

    function remove(uint index) public {
        uint len = numbers.length;
        if (index == len - 1) {
            numbers.pop();
        } else {
            numbers[index] = numbers[len - 1];
            numbers.pop();
        }
    }
}
