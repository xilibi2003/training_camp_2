# w4-vue

## 安装依赖

```sh
npm install
```

## 合约部署
使用w3_2_code 中的合约

```
npx hardhat run scripts/deploy_2612_bank.js --network hardhat 

```

若使用默认的助记词，则生成的ERC262的地址是：0x5FbDB2315678afecb367f032d93F642f64180aa3
Bank地址是：0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512



若你部署后的地址不一样，请修改 /deployments/dev/ERC2612.json 及  /deployments/dev/Bank.json

## 导出 ABI 复制到前端

 导出合约 ABI

```
npx hardhat export-abi
```

复制到前端

## 启动前端

```sh
npm run dev
```

## Compile and Minify for Production

```sh
npm run build
```

## JOSN_RPC 向节点发起请求

```
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", "latest"],"id":1}' http://127.0.0.1:8545
```


balanceOf
```
{
    "jsonrpc":"2.0",
    "method":"eth_call",
    "params":[
        {
            "to":"0x5fbdb2315678afecb367f032d93f642f64180aa3",
            "data":"0x70a08231000000000000000000000000f39Fd6e51aad88F6F4ce6aB8827279cffFb92266"
        },
        "latest"
    ],
    "id":123
}
```




npx hardhat console:

```

let b = await ethers.provider.getBalance("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266")

b
```


### 启动前端
```
npm run dev
```
