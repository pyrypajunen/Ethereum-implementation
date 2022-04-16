const Token = artifacts.require("MajToken");

var chai = require("chai");

const BN = web3.utils.BN;
const chaiBN = require('chai')(BN);
chai.use(chaiBN);


var chaiAsPromised = require("chai-as-promised");
chai.use(chaiAsPromised);


contract("Token Test", async accounts => {
    const [ initialHolder, recipient, anotherAccount ] = accounts;


    it("All tokens should be in my account", async () => {
    let instance = await Token.deployed();
    let totalSupply = await instance.totalSupply();
    await expect(instance.balanceOf(initialHolder)).to.eventually.be.a.bignumber.equal(totalSupply);
    });
});