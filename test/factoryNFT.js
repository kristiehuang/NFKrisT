require('dotenv').config();

const { expect } = require("chai");

const { ALCHEMY_API_URL, PRIVATE_KEY } = process.env;

describe("Minting the token and returning it", function () {
  it("should the contract be able to mint a function and return it", async function () {
    const FactoryContract = await ethers.getContractFactory("NFKrisT"); // Getting the contract

    const factoryContract = await FactoryContract.deploy(); //Deploying the Contract

    const transaction = await factoryContract.mintNFKrisT(4, {
        value: ethers.utils.parseEther("0.32")
    }); // Minting 4 of the token
    const tx = await transaction.wait() // Waiting for the token to be minted

    const nftsForThisAddress = await factoryContract.getTokensForAddress();
    expect(nftsForThisAddress.length).to.be.equal(4);

  });
});