<script>

import gql from 'graphql-tag'
export default {
  name: 'Users',
  apollo: {
    transfers: gql`query {
          transfers(first: 5) {
          id
          from
          to
          value
        }
      }`,
    users: gql`query {
          users(first: 5) {
            id
            balance
          }
      }`,
  },

  data() {
    return {
      transfers: null,
      users: null,
    }
  },

  async created() {
  },

  methods: {
  }
}


</script>

<template>
  <div >
    <div>
    交易列表:
  </div>
      <div v-for="(item, index) in transfers">
        <br /> 从 : {{ item.from  }}
        <br /> 到 : {{  item.to }}
        <br /> 金额 : {{  item.value }}
      </div>

      <div>------------------</div>

      <div>
        用户列表:
      </div>
      <div v-for="(item, index) in users">
        <br /> 地址 : {{ item.id  }}
        <br /> 持有 : {{  item.balance }}
      </div>
  </div>
</template>
