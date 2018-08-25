var OrganFactory = artifacts.require("./OrganFactory.sol");
var Hospitals = artifacts.require("./Hospitals.sol");
var User = artifacts.require("./User.sol")

module.exports = function(deployer) {
  deployer.deploy(OrganFactory);
};

module.exports = function(deployer) {
  deployer.deploy(Hospitals);
};

module.exports = function(deployer) {
  deployer.deploy(User);
};
