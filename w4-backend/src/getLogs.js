const { ethers } = require("ethers");

const ERC20ABI = require(`../deployments/abi/ERC2612.json`)
const ERC20Addr = require(`../deployments/dev/ERC2612.json`)

async function parseTransferEvent(event) {
    const TransferEvent = new ethers.utils.Interface(["event Transfer(address indexed from,address indexed to,uint256 value)"]);
    let decodedData = TransferEvent.parseLog(event);
    console.log("from:" + decodedData.args.from);
    console.log("to:" + decodedData.args.to);
    console.log("value:" + decodedData.args.value.toString());

    // insert to db
}

async function main() {
    
    const provider = new ethers.providers.JsonRpcProvider("http://localhost:8545");
    
    let myerc20 = new ethers.Contract(ERC20Addr.address, ERC20ABI, provider)

    let filter = myerc20.filters.Transfer()
    filter.fromBlock = 1;
    filter.toBlock = 10;

    // let events = await myerc20.queryFilter(filter);
    let events = await provider.getLogs(filter);
    for (let i = 0; i < events.length; i++) {
        // console.log(events[i]);
        parseTransferEvent(events[i]);
    }
}

main()