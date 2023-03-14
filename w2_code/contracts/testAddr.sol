pragma solidity ^0.8.0;

contract testAddr {
   

   constructor() payable {

   }

   // 如果合约的余额大于等于10，则给x转10 wei
	function testTrasfer(address payable x) public {
	   address myAddress = address(this);

        if (myAddress.balance >= 10 ether) {
            x.transfer(10 ether);
        }
	}

   function balance(address addr) public view returns (uint) {
      return addr.balance;
   }

}

