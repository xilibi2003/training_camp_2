const { ethers, upgrades } = require("hardhat");


const { getImplementationAddress } = require('@openzeppelin/upgrades-core');

async function main() {
  // Deploying
  const CounterWithOz = await ethers.getContractFactory("CounterWithOz");
  const instance = await upgrades.deployProxy(CounterWithOz, [42]);
  await instance.deployed();

  // 部署逻辑合约 
  // 部署代理 TransparentUpgradeableProxy
  // 部署代理管理员  ProxyAdmin
  


  // Upgrading
  // const CounterWithOz2 = await ethers.getContractFactory("CounterWithOz2");
  // const upgraded = await upgrades.upgradeProxy(instance.address, CounterWithOz2);

  //   let currentImplAddress = await getImplementationAddress(ethers.provider, upgraded.address);
  // console.log(`Please verify AppController: npx hardhat verify ${currentImplAddress} `);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });