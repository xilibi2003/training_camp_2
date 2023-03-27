const { ethers, upgrades } = require("hardhat");


const { getImplementationAddress } = require('@openzeppelin/upgrades-core');



async function main() {
  // Deploying
  const MyERC20V1 = await ethers.getContractFactory("MyERC20V1");
  const instance = await upgrades.deployProxy(MyERC20V1);
  await instance.deployed();

  console.log(`MyERC20: npx hardhat verify ${instance.address} `);

  // 部署逻辑合约 
  // 部署代理 TransparentUpgradeableProxy
  // 部署代理管理员  ProxyAdmin
  

  // Upgrading
  const MyERC20V2 = await ethers.getContractFactory("MyERC20V2");
  const upgraded = await upgrades.upgradeProxy(instance.address, MyERC20V2);

    let currentImplAddress = await getImplementationAddress(ethers.provider, upgraded.address);
  console.log(`Please verify MyERC20V2: npx hardhat verify ${currentImplAddress} `);



}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });