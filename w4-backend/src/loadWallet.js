const { ethers } = require("ethers")
let dotenv = require('dotenv')
dotenv.config()

module.exports = {
    wssMnemonicWallet: function (index) {
        let provider = new ethers.providers.WebSocketProvider(
            process.env.WSS_PROVIDER_URL
        )
        const mnemonic = process.env.MNEMONIC
        const path = "m/44'/60'/0'/0/" + index

        let walletMnemonic = ethers.Wallet.fromMnemonic(mnemonic,path)
        return walletMnemonic.connect(provider)
    },
}