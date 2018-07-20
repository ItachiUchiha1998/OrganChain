//var ConvertLib = artifacts.require("./ConvertLib.sol");
//var MetaCoin = artifacts.require("./MetaCoin.sol");
var OrganFactory = artifacts.require("./OrganFactory.sol");
module.exports = function(deployer) {
  deployer.deploy(OrganFactory);
};
