pragma solidity ^0.8.0;


contract GasOpt {
  uint128 a;
  uint256 b;
  uint128 c;



  struct Data {
      uint64 a;
      uint256 b;
      uint128 c;
      uint64 d;
  }


  Data data;


  constructor() {
    a = 1;
    b = 1;
    c = 1;

    data = Data({
      a:1,
      b:1,
      c:1,
      d:2
    });
  }

}