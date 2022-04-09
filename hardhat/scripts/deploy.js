// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
const ethers = hre.ethers;

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  //   await hre.run('compile');

  // We get the contract to deploy
  const ClubFactory = await ethers.getContractFactory("ClubFactory");
  const clubFactory = await ClubFactory.deploy();

  await clubFactory.deployed();
  console.log("clubFactory was deployed to:", clubFactory.address);

  const dummyNftClub = await clubFactory.createClub(
    "0x78e0f68e9b1cc533bb40c4cab027f0e302acd0f1"
  );

  console.log("DummyNft Club was deployed to:", dummyNftClub);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
