let {ethers} = require("hardhat");
let { writeAddr } = require('./artifact_log.js');

async function main() {
  // await run('compile');
  let [owner, second] = await ethers.getSigners();

  let Token = await ethers.getContractFactory("Token");
  let aAmount = ethers.utils.parseUnits("100000", 18);
  let atoken = await Token.deploy(
    "AToken", 
    "AToken",
    aAmount);

  await atoken.deployed();
  console.log("AToken:" + atoken.address);

  let bAmount = ethers.utils.parseUnits("200000", 18);
  let btoken = await Token.deploy(
    "BToken", 
    "BToken",
    bAmount);

  await btoken.deployed();
  console.log("BToken:" + btoken.address);

  let MiniSwapPool = await ethers.getContractFactory("MiniSwapPool");
  let pool = await MiniSwapPool.deploy(
    atoken.address, 
    btoken.address);

  await pool.deployed();
  console.log("MiniSwapPool:" + pool.address);
  // await writeAddr(pool.address, "Pool", network.name)

  await atoken.approve(pool.address, aAmount)
  await btoken.approve(pool.address, bAmount)

  await pool.add(ethers.utils.parseUnits("50000", 18), ethers.utils.parseUnits("100000", 18));
  console.log("添加流动性");

  let amountIn = ethers.utils.parseUnits("2", 18);
  let out = await pool.getAmountOut (amountIn, atoken.address);
  console.log("2 AToken  = " + ethers.utils.formatUnits(out[0], 18) + " BToken")

  amountIn = ethers.utils.parseUnits("200", 18);
  out = await pool.getAmountOut (amountIn, atoken.address);
  console.log("200 AToken  = " + ethers.utils.formatUnits(out[0], 18) + " BToken")


  amountIn = ethers.utils.parseUnits("2000", 18);
  out = await pool.getAmountOut (amountIn, atoken.address);
  console.log("2000 AToken  = " + ethers.utils.formatUnits(out[0], 18) + " BToken")

  console.log("second:" + second.address)
  await pool.swap(amountIn, out[0].toString(),
    atoken.address, btoken.address, second.address);
  
  let holderOfb = await btoken.balanceOf(second.address);
  console.log("holderOfb:" + ethers.utils.formatUnits(holderOfb, 18));

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
