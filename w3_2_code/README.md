# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```



## Request

```
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0xe74c813e3f545122e88A72FB1dF94052F93B808f", "latest"],"id":1}' http://127.0.0.1:8545
```


npx hardhat console:

```

let b = await ethers.provider.getBalance("0xe74c813e3f545122e88A72FB1dF94052F93B808f")

b
```

