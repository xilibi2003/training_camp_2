import { createApp, h } from 'vue'

import App from './App.vue'

import { ApolloClient, createHttpLink, InMemoryCache } from '@apollo/client/core'
import { createApolloProvider } from '@vue/apollo-option'

// 与 API 的 HTTP 连接
const httpLink = createHttpLink({
  // 你需要在这里使用绝对路径
  uri: 'http://localhost:3020/graphql',
})

// 缓存实现
const cache = new InMemoryCache()

// 创建 apollo 客户端

const apolloClient = new ApolloClient({
  cache,
  uri: 'https://api.thegraph.com/subgraphs/name/xilibi2003/the-sample',
})

// const apolloClient = new ApolloClient({
//   link: https://api.thegraph.com/subgraphs/name/xilibi2003/the-sample,
//   cache,
// })

const apolloProvider = createApolloProvider({
  defaultClient: apolloClient,
})


const app = createApp({
  render: () => h(App),
})

app.use(apolloProvider)

app.mount('#app')
