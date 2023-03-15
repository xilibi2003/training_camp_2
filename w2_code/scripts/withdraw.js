
const { ethers, network, artifacts } = require("hardhat");


async function main() {
  let bank = await ethers.getContractAt("Bank",
    "0x5FbDB2315678afecb367f032d93F642f64180aa3");

    let tx = await bank.withdrawAll();
    await tx.wait();

    console.log("withdrawed")

}

main();



