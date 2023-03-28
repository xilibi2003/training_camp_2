const { ethers } = require("ethers");

const ERC20ABI = require(`../deployments/abi/ERC2612.json`)
const ERC20Addr = require(`../deployments/dev/ERC2612.json`)


function getFunctionID() {
    let transferTopic = ethers.utils.keccak256(
    ethers.utils.toUtf8Bytes("Transfer(address,address,uint256)"));
    console.log("transferTopic:" + transferTopic)
    let id = ethers.utils.id("Transfer(address,address,uint256)")
    console.log("Transfer:" + id);
}

async function parseTransferEvent(event) {
    const TransferEvent = new ethers.utils.Interface(["event Transfer(address indexed from,address indexed to,uint256 value)"]);
    let decodedData = TransferEvent.parseLog(event);
    console.log("from:" + decodedData.args.from);
    console.log("to:" + decodedData.args.to);
    console.log("value:" + decodedData.args.value.toString());
}

async function main() {
    let provider = new ethers.providers.WebSocketProvider('ws://127.0.0.1:8545/')
    let myerc20 = new ethers.Contract(ERC20Addr.address, ERC20ABI, provider)

    let filter = myerc20.filters.Transfer()

    // let filter = myerc20.filters.Transfer(owner.address)
    // let filter = myerc20.filters.Transfer(null, owner.address)
    // logsFrom = await erc20.queryFilter(filter, -10, "latest");

    // filter = {
    //     address: ERC20Addr.address,
    //     topics: [
    //         ethers.utils.id("Transfer(address,address,uint256)")
    //     ]
    // }

    provider.on(filter, (event) => {
        console.log(event)
        parseTransferEvent(event);
    })
}

main()