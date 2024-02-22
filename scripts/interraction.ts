

async function main(): Promise<void> {
  const { ethers } = require("hardhat");

  const Vault = await ethers.getContractFactory("Vault");

  const contractAddress: string = "0x8d3d5f52F2548DBB43F03E8e1352733Ba56c05eB";
  const vault = await Vault.attach(contractAddress);


async function depositFunds(amount: number): Promise<void> {
  const amountInEther = ethers.parseEther(amount.toString());

  // Specify gas price and gas limit
  const overrides = {
    gasPrice: ethers.parseUnits("10", "gwei"), // Adjust the gas price as needed
    gasLimit: 100000, // Adjust the gas limit as needed
    value: amountInEther,
  };

  const tx = await vault.deposit(overrides);
  await tx.wait();

  console.log(`Deposited ${amount} ether into the contract.`);
}


  async function claimFunds(): Promise<void> {
   
    const tx = await vault.claim();

    await tx.wait();

    console.log("Claimed funds as the beneficiary.");
  }

 
  try {
    await depositFunds(1); // Deposit 1 ether
    await claimFunds(); // Claim funds as the beneficiary
  } catch (error) {
    console.error("Error:", error);
  }
}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
