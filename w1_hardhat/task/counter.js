// npx hardhat help counter
// npx hardhat counter --address 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 --network dev

task("counter", "Prints current counter vaule")
.addParam("address", "The counter's address")  
.setAction(async (taskArgs) => {
  const contractAddr = taskArgs.address;
  let counter = await ethers.getContractAt("Counter",
    contractAddr);

  let currValue = await counter.counter();

  console.log("current counter vaule:" + currValue);
});

module.exports = {};

