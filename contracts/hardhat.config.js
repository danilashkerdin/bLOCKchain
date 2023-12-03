require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config()

const IOTEX_PRIVATE_KEY = process.env.IOTEX_PRIVATE_KEY;

task("open", "Opens up the SmartLock")
  .addParam("contractaddress", "address of the contract")
  .setAction(async ({contractaddress }) => {
    console.log(
      "Opening lock for contract: ",
      contractaddress
    );

    const Lock = await ethers.getContractFactory("Lock");
    const lock = await Lock.attach(contractaddress);

    let ret = await lock.open();
    console.log("open:", ret);
  });

  task("close", "Closes down the SmartLock")
  .addParam("contractaddress", "address of the contract")
  .setAction(async ({contractaddress }) => {
    console.log(
      "Closing lock for contract: ",
      contractaddress
    );

    const Lock = await ethers.getContractFactory("Lock");
    const lock = await Lock.attach(contractaddress);

    let ret = await lock.close();
    console.log("close:", ret);
  });

  task("getIsOpen", "Gets the state of the SmartLock")
  .addParam("contractaddress", "address of the contract")
  .setAction(async ({ contractaddress }) => {
    console.log(
      "Getting isOpen from contract: ",
      contractaddress
    );

    const Lock = await ethers.getContractFactory("Lock");
    const lock = await Lock.attach(contractaddress);

    let ret = await lock.isOpen();
    console.log("getIsOpen:", ret);
  });

  // TODO: дописать команды в конфиг

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.23",
  networks: {
    testnet: {
      url: "https://babel-api.testnet.iotex.io",
      accounts: [`${IOTEX_PRIVATE_KEY}`],
    },
    mainnet: {
      url: "https://babel-api.mainnet.iotex.io",
      accounts: [`${IOTEX_PRIVATE_KEY}`],
    },
  }
};