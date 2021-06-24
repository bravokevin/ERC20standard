const { expect } = require("chai");
const { ethers } = require("ethers");

describe("Bravo", function (){
    before(async function(){
        const contract = await ethers.getContractFactory("Bravo")

        const [owner, spender, ...acounts] = await ethers.getSigners();
    })

    beforeEach(async function(){
        const BravoToken = await contract.deploy("Bravo", "BRV")
        await BravoToken.deployed()
    })

    it("should initizlized correctly", async function() {
        expect(await BravoToken.name).to.equal("Bravo");
        expect(await BravoToken.symbol).to.equal("BRV")
    })
})