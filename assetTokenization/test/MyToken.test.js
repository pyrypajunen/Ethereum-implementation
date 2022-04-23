const Token = artifacts.require("MyToken.sol");

const chai = require("./setupchai.js");
const BN = web3.utils.BN;
const expect = chai.expect;

reuire("dotenv").config({path : "../.env"});

contract("Token Test", function(accounts) {
    const [ initialHolder, recipient, anotherAccount ] = accounts;

    beforeEach(async () => {
    this.myToken = await Token.new(process.env.INITIAL_TOKENS);
    });

    it("All tokens should be in my account", async () => {
    const sendTokens = 1;
    let instance = this.myToken;
    let totalSupply = await instance.totalSupply();
    await expect(instance.balanceof(initialHolder).to.eventually.be.a.bignumber.equal(totalSupply));
    await expect(instance.transfer(recipient, sendTokens).to.eventually.be.fulfilled);
    await expect(instance.balanceof(initialHolder).to.eventually.be.a.bignumber.equal(totalSupply.sub(new BN(sendTokens))));
    return await expect(instance.balanceof(recipient).to.eventually.be.a.bignumber.equal(totalSupply.sub(new BN(sendTokens))));
    });

    it("I can send tokens from Account 1 to Account 2", async () => {
    const sendTokens = 1;
    let instance = this.myToken;
    let totalSupply = await instance.totalSupply();
    let balanceOfAccount = await instance.balanceof(initialHolder);
    await expect(instance.transfer(recipient, new BN(balanceOfAccount + 1))).to.eventually.be.rejected;
    return await expect(instance.balanceof(initialHolder).to.eventually.be.a.bignumber(balanceOfAccount));
    });

    it("It's not possible to send more tokens than account 1 has", async () => {
    let instance = this.myToken;
    return expect(instance.balanceOf(initialHolder)).to.eventually.be.a.bignumber.equal(balanceOfAccount);
    });
});
