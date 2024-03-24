const { ethers } = require("hardhat");

const main = async () => {
  // Get the contract factory for SoulToken
  const SoulTokenFactory = await ethers.getContractFactory("SoulToken");

  // Define the fee in wei (0.001 ether in wei)
  const feeInWei = ethers.utils.parseEther("0.001");

  // Deploy the contract with the specified fee
  const soulToken = await SoulTokenFactory.deploy(feeInWei);

  // Wait for the contract to be deployed
  await soulToken.deployed();

  // Log the address where the contract is deployed
  console.log("SoulToken deployed to:", soulToken.address);
};

// Execute the main function
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
