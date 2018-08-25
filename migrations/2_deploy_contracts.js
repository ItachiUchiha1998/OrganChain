var OrganFactory = artifacts.require("./OrganFactory.sol");
var Hospital = artifacts.require("./Hospital.sol");
var User = artifacts.require("./User.sol")

module.exports = function(deployer) {
  deployer.deploy(OrganFactory);
};

module.exports = function(deployer) {
  deployer.deploy(Hospital);
};

module.exports = function(deployer) {
  deployer.deploy(User);
};
