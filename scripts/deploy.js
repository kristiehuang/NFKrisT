async function main() {
    const NFKrisT = await ethers.getContractFactory("NFKrisT")
    console.log("contract gotten; starting deployment")
  
    // Start deployment, returning a promise that resolves to a contract object
    const nftContract = await NFKrisT.deploy()
    await nftContract.deployed()
    console.log("Contract deployed to address:", nftContract.address)
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error)
      process.exit(1)
    })
  