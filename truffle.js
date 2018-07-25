// Allows us to use ES6 in our migrations and tests.
require('babel-register')

module.exports = {
  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*' // Match any network id
    }
  }
}

//OrganFactory.deployed().then(function(instance){return instance.getOrgan(0);}).then(function(v){console.log(v.toString(10));}).catch(function(e){ console.log(e) })  

/*
	paperwork
	red taping
	user privacy

*/

/* 

	front-end

	later: 
		hospital schema: 
    	address
    	organs
    	accept method
	
	
*/