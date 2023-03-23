## forge 

### build
```
forge build
```

### test 

```
forge test
```


### deploy

forge script

```
forge script script/ERC2612.s.sol --rpc-url local --broadcast
```

```
forge script script/MyERC20.s.sol --rpc-url local --broadcast --verify
```

0x21b4d1f6d42dc6083db848d42aa4b6895371e1e7


```
forge create  src/Counter.sol:Counter  --rpc-url local  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```

## cast

```
cast call 0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82 "counter()" --rpc-url local

cast send 0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82 "setNumber(uint256)" 1 --rpc-url local --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```


## anvil

```
anvil

anvil --port <PORT>
anvil -m "test test test test test test test test test test test junk"

```

## NFT  

https://www.pinata.cloud/



