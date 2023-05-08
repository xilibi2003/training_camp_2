
const { DefenderRelayProvider } = require('defender-relay-client/lib/web3');

const Web3 = require('web3');
const ABI = [{
      "inputs": [],
      "name": "count",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    }];

const ADDRESS = '0x0EB88f36299356788C209050655eF54AA8c6A957'

exports.handler = async function(credentials) {

  const provider = new DefenderRelayProvider(credentials, { speed: 'fast' });
  const web3 = new Web3(provider);
  
    const [from] = await web3.eth.getAccounts();
  
  const contract = new web3.eth.Contract(ABI, ADDRESS, {from });
  const txRes = await contract.methods.count().send();
  
  console.log(txRes);
  return txRes.hash;
}
