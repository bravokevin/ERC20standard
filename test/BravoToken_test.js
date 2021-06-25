const { expect } = require("chai");

describe("Bravo", function (){

    const TOTAL_SUPPLY = 1000 ;

    let owner;
    let spender
    let accounts
    let BravoToken
    let contract

    before(async function(){
     this.contract = await ethers.getContractFactory("BravoToken");

       [owner, spender, ...acounts] = await ethers.getSigners();
    })

    beforeEach(async function () {
        this.BravoToken = await this.contract.deploy()
        await this.BravoToken.deployed()
    })
    describe("Deployment", function() {
        it("should initizlized correctly", async function() {
            expect(await this.BravoToken.name()).to.equal("Bravo");
            expect(await this.BravoToken.symbol()).to.equal("BRV")
            expect(await this.BravoToken.decimals()).to.equal(36);

            await this.BravoToken.mint(TOTAL_SUPPLY);
            expect(await this.BravoToken.balanceOf(owner.address)).to.equal(TOTAL_SUPPLY)
        })
    })




})