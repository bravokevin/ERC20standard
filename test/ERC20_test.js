const { expect } = require("chai");

describe("Bravo", function (){

    let owner;
    let spender
    let accounts
    let ERC20Token
    let contract

    before(async function(){
     contract = await ethers.getContractFactory("ERC20");

       [owner, spender, ...acounts] = await ethers.getSigners();
    })

    beforeEach(async function () {
        ERC20Token = await contract.deploy("ERC20", "ERC")
        await ERC20Token.deployed()
    })
    describe("Deployment", function() {
        it("should initizlized correctly", async function() {
            expect(await ERC20Token.name()).to.equal("ERC20");
            expect(await ERC20Token.symbol()).to.equal("ERC")
            expect(await ERC20Token.decimals()).to.equal(36);

        })
    })




})