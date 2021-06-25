const { expect } = require("chai");

describe("Bravo", function (){
    before(async function(){
     contract = await ethers.getContractFactory("Bravo");

       [owner, spender, ...acounts] = await ethers.getSigners();
    })

    beforeEach(async function () {
        BravoToken = await contract.deploy("Bravo", "BRV")
        await BravoToken.deployed()
    })

    it("should initizlized correctly", async function() {
        expect(await BravoToken.name()).to.equal("Bravo");
        expect(await BravoToken.symbol()).to.equal("BRV")
    })
})