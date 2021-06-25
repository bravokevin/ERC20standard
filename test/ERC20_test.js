const { expect } = require("chai");

describe("ERC20", function (){

    let owner;
    let spender
    let accounts
    let ERC20Token
    let contract

    before(async function(){
     this.contract = await ethers.getContractFactory("ERC20");

       [owner, spender, ...acounts] = await ethers.getSigners();
    })

    beforeEach(async function () {
        this.ERC20Token = await this.contract.deploy("ERC20", "ERC")
        await this.ERC20Token.deployed()
    })
    describe("Deployment", function() {
        it("should initizlized correctly", async function() {
            expect(await this.ERC20Token.name()).to.equal("ERC20");
            expect(await this.ERC20Token.symbol()).to.equal("ERC")
            expect(await this.ERC20Token.decimals()).to.equal(36);

        })
    })




})