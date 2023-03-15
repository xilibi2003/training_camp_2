const { ethers, network, artifacts } = require("hardhat");



async function main() {
  // await hre.run('compile');
  const Bank = await ethers.getContractFactory("Bank");

  const bank = await Bank.deploy();

  await bank.deployed();

  console.log("Bank deployed to:", bank.address);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });




