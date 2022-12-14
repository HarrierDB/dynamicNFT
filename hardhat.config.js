require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  defaultNetworks: 'mumbai',
    networks: {
        mumbai: {
            url: process.env.MUMBAI_URL,
            accounts: [process.env.PRIVATE_KEY],
        }
    },
    etherscan: {
      apiKey: process.env.ETHERSCAN_API_KEY
    }
};
