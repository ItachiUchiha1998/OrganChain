var OrganFactory = artifacts.require("./OrganFactory.sol");
var Hospitals = artifacts.require("./Hospitals.sol");
var User = artifacts.require("./User.sol")

// module.exports = function(deployer) {
//   deployer.deploy(OrganFactory,Hospitals,User);
// };
module.exports = function(deployer) {
	deployer.deploy(OrganFactory)
	.then(function() {
	  return deployer.deploy(Hospitals);
	}).then(function(){
		return deployer.deploy(User);
	}).catch(function(err){
		console.error(err)
	});	
}