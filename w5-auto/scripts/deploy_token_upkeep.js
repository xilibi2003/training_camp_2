const { ethers, network, artifacts } = require("hardhat");
const { writeAbiAddr } = require('./artifact_saver.js');

async function main() {
  // await hre.run('compile');
  const CAMP2Token = await ethers.getContractFactory("CAMP2Token");
  const token = await CAMP2Token.deploy();
  await token.deployed();
  // tx.wait();

  console.log("CAMP2Token deployed to:", token.address);
  let TokenArtifact = await artifacts.readArtifact("CAMP2Token");
  await writeAbiAddr(TokenArtifact, token.address, "CAMP2Token", network.name);


  const Bank = await ethers.getContractFactory("Bank");
  const bank = await Bank.deploy(token.address);
  await bank.deployed();

  console.log("Bank deployed to:", bank.address);
  let BankArtifact = await artifacts.readArtifact("Bank");
  await writeAbiAddr(BankArtifact, bank.address, "Bank", network.name);


  const Auto = await ethers.getContractFactory("AutoCollectUpKeep");
  const auto = await Auto.deploy(token.address, bank.address);
  await auto.deployed();

  console.log("Auto deployed to:", auto.address);
  let AutoArtifact = await artifacts.readArtifact("AutoCollectUpKeep");
  await writeAbiAddr(AutoArtifact, auto.address, "AutoCollectUpKeep", network.name);


}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });




