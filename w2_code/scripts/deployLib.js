const { ethers, network, artifacts } = require("hardhat");

async function main() {
  // await hre.run('compile');
  const ExLib = await ethers.getContractFactory("ExLib");

  const exlib = await ExLib.deploy();

  await exlib.deployed();

  const TestEx = await ethers.getContractFactory("TestExLib", {
    libraries: {
      ExLib: exlib.address
    }
  }
  );

  const testEx = await TestEx.deploy();
  await testEx.deployed();

  await testEx.testAdd(1, 2);


  console.log("TestEx deployed to:", testEx.address);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });




