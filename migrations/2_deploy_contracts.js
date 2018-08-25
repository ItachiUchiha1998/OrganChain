//var ConvertLib = artifacts.require("./ConvertLib.sol");
//var MetaCoin = artifacts.require("./MetaCoin.sol");
var OrganFactory = artifacts.require("./OrganFactory.sol");
// var Hospital = artifacts.require("./Hospital.sol");

module.exports = function(deployer) {
  deployer.deploy(OrganFactory);
};

// module.exports = function(deployer) {
//   deployer.deploy(Hospital);
// };
