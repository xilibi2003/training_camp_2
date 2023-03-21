pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC777/ERC777.sol";

contract MyERC777 is ERC777 {
    constructor() ERC777("MY777", "M777", new address[](0))
    {
        _mint(msg.sender, 1000 * 10 ** 18, "", "");
    }
}