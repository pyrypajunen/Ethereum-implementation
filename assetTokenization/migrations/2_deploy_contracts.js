var MajToken = artifacts.require("MajToken.sol");
var MyTokenSale = artifacts.require("MyTokenSale.sol");

module.exports = async function(deployer) {
  let address = await web3.eth.getAccounts();
  deployer.deploy(MajToken, 500);
  deployer.deploy(MyTokenSale,1, address[0], MajToken.address);
  let instance = await MyTokenSale.deployed();
  instance.transfar(MyTokenSale.address, 500);
};