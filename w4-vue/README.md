# w4-vue

## 安装依赖

```sh
npm install
```

## 合约部署
使用w3_code 中的合约

```
forge script script/ERC2612.s.sol --rpc-url local --broadcast
forge script script/Bank.s.sol --rpc-url local --broadcast
```

若使用默认的助记词，则生成的ERC262的地址是：0x5FbDB2315678afecb367f032d93F642f64180aa3

Bank地址是：0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512

若你部署后的地址不一样，请修改 /deployments/dev/ERC2612.json 及  /deployments/dev/Bank.json


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
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0xe74c813e3f545122e88A72FB1dF94052F93B808f", "latest"],"id":1}' http://127.0.0.1:8545
```



```
{
    "jsonrpc":"2.0",
    "method":"eth_call",
    "params":[
        {
            "to":"0x86Fa049857E0209aa7D9e616F7eb3b3B78ECfdb0",
            "data":"0x70a0823100000000000000000000000033b8287511ac7F003902e83D642Be4603afCd876"
        },
        "latest"
    ],
    "id":123
}
```


npx hardhat console:

```

let b = await ethers.provider.getBalance("0xe74c813e3f545122e88A72FB1dF94052F93B808f")

b
```


### 启动前端
```
npm run dev
```
