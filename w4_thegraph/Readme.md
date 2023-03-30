
## GraphQL

https://graphql.org/swapi-graphql

```
{
	allFilms {
    films {
      title,
      releaseDate
      ,episodeID
    }
  }
}

```

```
{
  film (filmID: 1) {
          title,
      releaseDate
  }
}
```


# TheGraph 开发步骤

先部署 Token 到测试网络，并开源验证

这里使用： 0x562C00463801C9E3815d68A76DAB9940d8f8dFed


## 安装 Graph CLI#
```
npm install -g @graphprotocol/graph-cli
```

## TheGraph 工程初始化

```
graph init --product hosted-service xilibi2003/the-sample


> chaintype: ethereum
> xilibi2003/the-sample
> network: mumbai
> Contract: 0x562C00463801C9E3815d68A76DAB9940d8f8dFed
> Start Block: 33703557
```


生成的目录结构：

```
subgraph.yaml : Manifest 清单
schema.graphql: Schema 模式, 定义索引的主体， 类似定义MySQL 表结构
src/mapping.ts: Mapping 映射, 编写索引规则 
```

在初始化项目时，填写的一系列配置会写入到 `subgraph.yaml` 中,  `subgraph.yaml` 会定义：


* 要索引哪些智能合约(地址，网络，ABI...)
* 监听哪些事件
* 其他要监听的内容，例如函数调用或块
* 被调用的映射函数，在那个文件

## schema.graphql

定义好实体后运行

```
npm run codegen
或graph codegen 
```

会帮我们生成实体类，再去编写映射规则。

## 编写映射（事件处理代码）

src/erc-2612.ts

graph-ts

参考 assemblyscript-api 


```
graph build
```




## 发布

```
graph auth --product hosted-service 0978103786544c68a3be3ce04708d69b
```

```
graph deploy --product hosted-service xilibi2003/the-sample
```

发布之后，

 TheGraph 会帮我们索引数据， 等待一会。


https://api.thegraph.com/subgraphs/name/xilibi2003/the-sample