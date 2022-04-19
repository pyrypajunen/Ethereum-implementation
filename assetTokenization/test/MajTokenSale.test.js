const TokenSale = artifacts.require("MajTokenSale");
const Token = artifacts.require("MajToken");

const chai = require("./setupchai.js");
const BN = web3.utils.BN;
const expect = chai.expect;

reuire("dotenv").config({path : "../.env"});

contract("Token Test", function(accounts) {

    const [ initialHolder, recipient, anotherAccount ] = accounts;

    it("Should not have any tokens in my initialHolder account", async () => {
        let instance = Token.deployed();
        return expect(instance.balanceOf(initialHolder).to.eventually.be.a.bignumber.equal(new BN(0)));
    });

    it("all coins should be in the tokensale smart contract", async () => {
        let instance = await Token.deployed();
        let balance = await instance.balanceOf.call(TokenSale.address);
        let totalSupply = await instance.totalSupply.call();
        return expect(balance).to.be.a.bignumber.equal(totalSupply);
    });
    
    it("should be possible to buy one token by simply sending ether to the smart contract", async () => {
        let tokenInstance = await Token.deployed();
        let tokenSaleInstance = await TokenSale.deployed();
        let balanceBeforeAccount = await tokenInstance.balanceOf.call(recipient);
    
        await expect(tokenSaleInstance.sendTransaction({from: recipient, value: web3.utils.toWei("1", "wei")})).to.be.fulfilled;
        return expect(balanceBeforeAccount + 1).to.be.bignumber.equal(await tokenInstance.balanceOf.call(recipient));
    
    });

    it("All tokens should be in the TokenSale smart contrac by default", async () => {
        let instance = await Token.deployed();
        let balanceOfContract = await instance.balanceOf(TokenSale.address); 
        let totalSupply = await instance.totalSupply();
        return await expect(balanceOfContract).to.be.eventually.a.bignumber.equal(totalSupply);
    });

    it("Should be possible to buy a tokens", async () => {
        let instance = await Token.deployed();
        let tokenSalesInstance = await TokenSale.deployed();
        let balancebefore = await instance.balanceOf(initialHolder);
        expext(tokenSalesInstance.sendTransaction({from: initialHolder, value: web3.utils.toWei("1", "wei")})).to.be.fulfilled;
        return expect(tokenSalesInstance.balanceOf(initialHolder)).to.eventually.be.a.bignumber.equal(balancebefore.add(new BN(1)));
    })
});