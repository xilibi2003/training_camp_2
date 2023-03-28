const hre = require("hardhat");

async function main() {

  const ERC2612 = await hre.ethers.getContractFactory("ERC2612");
  const erc2612 = await ERC2612.deploy();

  await erc2612.deployed();

  console.log("erc2612 deployed finish address " + erc2612.address)


  const Bank = await hre.ethers.getContractFactory("Bank");
  const bank = await Bank.deploy(erc2612.address);

  await bank.deployed();
  console.log("bank deployed finish address " + bank.address)

}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});