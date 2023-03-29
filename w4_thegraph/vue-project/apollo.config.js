// apollo.config.js
module.exports = {
  client: {
    service: {
      name: 'my-app',
      url: 'https://api.thegraph.com/subgraphs/name/xilibi2003/the-sample',
    },
    // 通过扩展名选择需要处理的文件
    includes: [
      'src/**/*.vue',
      'src/**/*.js',
    ],
  },
}