var MajToken = artifacts.require("./MajToken.sol");

module.exports = function(deployer) {
  deployer.deploy(MajToken, 21000000);
};