const { ethers, network, artifacts } = require("hardhat");
const { writeAbiAddr } = require('./artifact_saver.js');

async function main() {
  // await hre.run('compile');
  const Counter = await ethers.getContractFactory("Counter");

  const counter = await Counter.deploy();


  await counter.deployed();
  // tx.wait();

  console.log("Counter deployed to:", counter.address);

  let tx = await counter.count();
  await tx.wait();

  let Artifact = await artifacts.readArtifact("Counter");
  await writeAbiAddr(Artifact, counter.address, "Counter", network.name);


  const CounterResolver = await ethers.getContractFactory("CounterResolver");

  const resoler = await CounterResolver.deploy(counter.address);
  await resoler.deployed();

  let ResolverArtifact = await artifacts.readArtifact("CounterResolver");
  await writeAbiAddr(ResolverArtifact, resoler.address, "CounterResolver", network.name);


}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });




