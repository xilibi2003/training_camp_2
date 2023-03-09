const { ethers, network, artifacts } = require("hardhat");
require('hardhat-abi-exporter');


const { writeAbiAddr } = require('./artifact_saver.js');


const contantJson = require('./contants.json');

async function main() {
  // await hre.run('compile');
  const Counter = await ethers.getContractFactory("Counter");
  const initVal = contantJson[network.name];


  console.log(initVal);
  console.log(initVal.INIT);

  const counter = await Counter.deploy(initVal.INIT);


  await counter.deployed();
  // tx.wait();

  console.log("Counter deployed to:", counter.address);

  let tx = await counter.count();
  await tx.wait();

  let Artifact = await artifacts.readArtifact("Counter");
  await writeAbiAddr(Artifact, counter.address, "Counter", network.name);

  console.log(`Please verify: npx hardhat verify ${counter.address}` );

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });




