const hre = require("hardhat");



//0x8F6b4D09Af5a52FE6d137947b03b25CdDEE01245
const main = async () => {
  try {
    const nftContractFactory = await hre.ethers.getContractFactory(
        "ChainBattles"
    );
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();

    console.log("Contract deployed to:", nftContract.address);
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

main();