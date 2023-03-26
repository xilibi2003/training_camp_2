
const hre = require("hardhat");

async function doPermit(erc2612) {
  const [owner, otherAccount] = await ethers.getSigners();

  const nonce = await erc2612.nonces(owner.address);
  const deadline = Math.ceil(Date.now() / 1000) + 60 * 60 * 24;
  const chainID = (await ethers.provider.getNetwork()).chainId;
  
  let amount =  ethers.utils.parseUnits("1").toString();

  const domain = {
      name: 'ERC2612',
      version: '1',
      chainId: chainID,
      verifyingContract: erc2612.address
  }

  const types = {
      Permit: [
        {name: "owner", type: "address"},
        {name: "spender", type: "address"},
        {name: "value", type: "uint256"},
        {name: "nonce", type: "uint256"},
        {name: "deadline", type: "uint256"}
      ]
  };

  const message = {
      owner: owner.address,
      spender: otherAccount.address,
      value: amount,
      nonce: nonce,
      deadline: deadline
  };

  const signature = await owner._signTypedData(domain, types, message);
  const {v, r, s} = ethers.utils.splitSignature(signature);

  let tx = await erc2612.permit(
    owner.address,
    otherAccount.address,
    amount,
    deadline,
    v,
    r,
    s
    );

  let allowanced = await erc2612.allowance(owner.address, otherAccount.address);
  console.log("allowanced:" + allowanced);
}

async function main() {

  const ERC2612 = await hre.ethers.getContractFactory("ERC2612");
  const erc2612 = await ERC2612.deploy();

  await erc2612.deployed();

  console.log("token deployed finish address " + erc2612.address)


  await doPermit(erc2612);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
