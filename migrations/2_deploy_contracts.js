//var ConvertLib = artifacts.require("./ConvertLib.sol");
//var MetaCoin = artifacts.require("./MetaCoin.sol");
var OrganFactory = artifacts.require("./OrganFactory.sol");
module.exports = function(deployer) {
  deployer.deploy(OrganFactory);
};

var PurchaseOrgan = artifacts.require("./Purchase_Organ.sol");
module.exports = function(deployer) {
  deployer.deploy(PurchaseOrgan);
};
