require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */

require("dotenv").config();

const INFURA_URL = process.env.INFURA_URL;
const PRIVATE_KEY_1 = process.env.PRIVATE_KEY_1;
const PRIVATE_KEY_2 = process.env.PRIVATE_KEY_2;

module.exports = {
  solidity: "0.7.6",
  networks: {
    hardhat: {
      forking: {
        url: INFURA_URL
      },
    },
    ganache: {
      url: "http://localhost:8545",
      accounts: [
        {
          privateKey: [PRIVATE_KEY_1]
        },
        {
          privateKey: [PRIVATE_KEY_2]
        }
      ],
    },
  },
};
