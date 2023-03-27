pragma solidity ^0.8.0;


import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

// 0x595c128a306ad9ae830030753e8f41201c314882
contract MyERC20V1 is ERC20Upgradeable {

  function initialize() external initializer {
      __ERC20_init("MyERC20", "MyERC20");

      _mint(msg.sender, 100000e18);
  }

}