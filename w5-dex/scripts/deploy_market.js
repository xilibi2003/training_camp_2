let { ethers } = require("hardhat");
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

    let MyTokenMarket = await ethers.getContractFactory("MyTokenMarket");

    let routerAddr = "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0";
    let wethAddr = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";

    let market = await MyTokenMarket.deploy(
        atoken.address,
        routerAddr,
        wethAddr,
    );

    await market.deployed();
    console.log("market:" + market.address);

    await atoken.approve(market.address, ethers.constants.MaxUint256);

    let ethAmount = ethers.utils.parseUnits("100", 18);
    await market.AddLiquidity(aAmount, { value: ethAmount })
    console.log("添加流动性");

    let b = await atoken.balanceOf(owner.address);
    console.log("持有token:" + ethers.utils.formatUnits(b, 18));

    let buyEthAmount = ethers.utils.parseUnits("10", 18);
    out = await market.buyToken("0", { value: buyEthAmount })

    b = await atoken.balanceOf(owner.address);
    console.log("购买到:" + ethers.utils.formatUnits(b, 18));

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });