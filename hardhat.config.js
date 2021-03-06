/**
* @type import('hardhat/config').HardhatUserConfig
*/
require('dotenv').config();
require("@nomiclabs/hardhat-ethers");

const { ALCHEMY_API_URL, DEV_PRIVATE_KEY } = process.env;

module.exports = {
   solidity: "0.8.0",
   networks: {
      hardhat: {},
      goerli: {
         url: ALCHEMY_API_URL,
         accounts: [`0x${DEV_PRIVATE_KEY}`]
      }
   },
}