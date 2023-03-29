import { createApp, h } from 'vue'

import App from './App.vue'

import { ApolloClient, InMemoryCache } from '@apollo/client/core'
import { createApolloProvider } from '@vue/apollo-option'

// 缓存实现
const cache = new InMemoryCache()

// 创建 apollo 客户端
const apolloClient = new ApolloClient({
  cache,
  uri: 'https://api.thegraph.com/subgraphs/name/xilibi2003/the-sample',
})

const apolloProvider = createApolloProvider({
  defaultClient: apolloClient,
})

const app = createApp({
  render: () => h(App),
})

app.use(apolloProvider)
app.mount('#app')
