const { expect } = require("chai");

let counter;
let owner, otherAccount;

describe("Counter", function () {
  async function init() {
    [owner, otherAccount] = await ethers.getSigners();
    const Counter = await ethers.getContractFactory("Counter");
    counter = await Counter.deploy(0);
    await counter.deployed();
    console.log("counter:" + counter.address);
  }

  before(async function () {
    await init();
  });

  // 
  it("count ok", async function () {
    expect(await counter.counter()).to.equal(0);
    let tx = await counter.count();
    await tx.wait();
    expect (await counter.counter()).to.equal(1);

  });

  it("count_with_revert", async function () {
    let counter2 = counter.connect(otherAccount);
    
    expect(counter2.count()).to.be.revertedWith("invalid call");
  });

});
