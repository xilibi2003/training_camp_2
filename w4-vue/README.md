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

## RPC 请求

```
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getBalance","params":["0xe74c813e3f545122e88A72FB1dF94052F93B808f", "latest"],"id":1}' http://127.0.0.1:8545
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
