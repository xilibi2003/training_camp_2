<script>
import { ethers } from 'ethers'

import erc2612Addr from '../../deployments/dev/ERC2612.json'
import erc2612Abi from '../../deployments/abi/ERC2612.json'

import bankAddr from '../../deployments/dev/Bank.json'
import bankAbi from '../../deployments/abi/Bank.json'

export default {

  name: 'erc20',

  data() {
    return {

      recipient: null,
      amount: null,
      balance: null,
      ethbalance: null,

      name: null,
      decimal: null,
      symbol: null,
      supply: null,

      stakeAmount: null,

    }
  },

  async created() {
    await this.initAccount()
    this.initContract()
    this.getInfo();
    this.getNonce();
  },

  methods: {
    async initAccount(){
      if(window.ethereum) {
        console.log("initAccount");
        try {
          this.currProvider = window.ethereum;
          this.provider = new ethers.providers.Web3Provider(window.ethereum);
          this.accounts = await this.provider.send("eth_requestAccounts", []);

          console.log("accounts:" + this.accounts);
          this.account = this.accounts[0];

          this.signer = this.provider.getSigner()
          let network = await this.provider.getNetwork()
          this.chainId = network.chainId;
          console.log("chainId:", this.chainId);

        } catch(error){
          console.log("User denied account access", error)
        }
      }else{
        console.log("Need install MetaMask")
      }
    },

    async initContract() {
      this.erc20Token = new ethers.Contract(erc2612Addr.address, 
        erc2612Abi, this.signer);

      this.bank = new ethers.Contract(bankAddr.address, 
        bankAbi, this.signer);

    }, 

    getInfo() {
      this.provider.getBalance(this.account).then((r) => {
        this.ethbalance = ethers.utils.formatUnits(r, 18);
      });

      this.erc20Token.name().then((r) => {
        this.name = r;
      })
      this.erc20Token.decimals().then((r) => {
        this.decimal = r;
      })
      this.erc20Token.symbol().then((r) => {
        this.symbol = r;
      })
      this.erc20Token.totalSupply().then((r) => {
        this.supply = ethers.utils.formatUnits(r, 18);
      })

      this.erc20Token.balanceOf(this.account).then((r) => {
        this.balance = ethers.utils.formatUnits(r, 18);
      })
      
    },

    getNonce() {
      this.erc20Token.nonces(this.account).then(r => {
        this.nonce = r.toString();
        console.log("nonce:" + this.nonce);
      })
    },

    transfer() {
      let amount = ethers.utils.parseUnits(this.amount, 18);
      this.erc20Token.transfer(this.recipient, amount).then((r) => {
        console.log(r);  // 返回值不是true
        this.getInfo();
      })
    },

    async permitDeposit() {
      this.deadline = Math.ceil(Date.now() / 1000) + parseInt(20 * 60);
      
      let amount =  ethers.utils.parseUnits(this.stakeAmount).toString();
      
      const domain = {
          name: 'ERC2612',
          version: '1',
          chainId: this.chainId,
          verifyingContract: erc2612Addr.address
      }

      const types = {
          Permit: [
            {name: "owner", type: "address"},
            {name: "spender", type: "address"},
            {name: "value", type: "uint256"},
            {name: "nonce", type: "uint256"},
            {name: "deadline", type: "uint256"}
          ]
      }

      const message = {
          owner: this.account,
          spender: bankAddr.address,
          value: amount,
          nonce: this.nonce,
          deadline: this.deadline
      }

      const signature = await this.signer._signTypedData(domain, types, message);
      console.log(signature);

      const {v, r, s} = ethers.utils.splitSignature(signature);
      this.bank.permitDeposit(this.account, amount, this.deadline, v, r, s, {
              from: this.account
            }).then(() => {
              this.getInfo();
              this.getNonce();
          })
    },
  }
}


</script>

<template>
  <div >

      <div>
        <br /> Token名称 : {{ name  }}
        <br /> Token符号 : {{  symbol }}
        <br /> Token精度 : {{  decimal }}
        <br /> Token发行量 : {{  supply }}
        <br /> 我的Token余额 : {{ balance  }}
        <br /> 我的ETH余额 : {{ ethbalance  }}
      </div>

      <div >
        <br />转账到:
        <input type="text" v-model="recipient" />
        <br />转账金额
        <input type="text" v-model="amount" />
        <br />
        <button @click="transfer()"> 转账 </button>
      </div>

    <div >
      <input v-model="stakeAmount" placeholder="输入质押量"/>
      <button @click="permitDeposit">离线授权存款</button>
    </div>

  </div>
</template>

<style scoped>
h1 {
  font-weight: 500;
  font-size: 2.6rem;
  top: -10px;
}

h3 {
  font-size: 1.2rem;
}

.greetings h1,
.greetings h3 {
  text-align: center;
}

div {
  font-size: 1.2rem;
}

@media (min-width: 1024px) {
  .greetings h1,
  .greetings h3 {
    text-align: left;
  }
}
</style>
