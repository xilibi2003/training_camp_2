
# w4-backend

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

## 启动后端

```sh
node src/getLogs.js    // 获取所有日志
```


```sh
node src/listenEvent.js    // 监听实时发生的日志
```
