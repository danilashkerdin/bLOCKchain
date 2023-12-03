// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const open = false;
  address = "0x34fD780D8796B70f47FbC3659d1cD8e7ce327c2B"

  const Lock = await hre.ethers.getContractFactory("Lock");
  const lock = await Lock.deploy(address, open);

  await lock.deployed();

  console.log("Lock deployed to: ", lock.address);
  console.log("Lock state: ", open);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
