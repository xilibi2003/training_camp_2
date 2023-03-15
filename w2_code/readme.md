# 习题解答说明



## 部署Bank 到 Hardhat 
```
npx hardhat node 
npx hardhat run scripts/deploybank.js --network dev
```

记录合约地址, 可以先参看一下合约余额：

```
npx hardhat balance --account 0x5FbDB2315678afecb367f032d93F642f64180aa3 --network dev
```

## 使用 Metamask 向合约转账

Metamask 先导入 Hardhat 生成的账号（有资金）。
然后转账

## 

```
npx hardhat run scripts/withdraw.js  --network dev
```