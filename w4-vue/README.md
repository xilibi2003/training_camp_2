# vue-project

This template should help get you started developing with Vue 3 in Vite.

## Recommended IDE Setup

[VSCode](https://code.visualstudio.com/) + [Volar](https://marketplace.visualstudio.com/items?itemName=johnsoncodehk.volar) (and disable Vetur) + [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=johnsoncodehk.vscode-typescript-vue-plugin).

## Customize configuration

See [Vite Configuration Reference](https://vitejs.dev/config/).

## Project Setup

```sh
npm install
```

### Compile and Hot-Reload for Development

```sh
npm run dev
```

### Compile and Minify for Production

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
