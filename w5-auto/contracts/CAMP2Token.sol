//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract CAMP2Token is ERC20Permit {

    constructor() ERC20("CAMP2", "CAMP2") ERC20Permit("CAMP2") {
        _mint(msg.sender, 100000 * 10 ** 18);
    }

    
}