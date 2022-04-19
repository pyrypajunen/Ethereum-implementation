var MajToken = artifacts.require("MajToken");
var MyTokenSale = artifacts.require("MyTokenSale");
require("dotenv").config({path: "../.env"});
// console.log(process.env)

module.exports = async function(deployer) {
    let addr = await web3.eth.getAccounts();
    await deployer.deploy(MajToken, process.env.INITIAL_TOKENS);
    await deployer.deploy(MyTokenSale, 1, addr[0], MajToken.address);
    let tokenInstance = await MajToken.deployed();
    await tokenInstance.transfer(MyTokenSale.address, process.env.INITIAL_TOKENS);
};