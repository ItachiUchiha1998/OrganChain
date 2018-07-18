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
	donate now and future

	ownership change after donation

	organ schema: 

		_name,
    	_donorId,
    	_hospitalDetails,
        blood group (from  id),


    aman - user schema:
    	- blood group
    	- organs array
    	- donate now 

    	
	aman - blood group filtering

	mapping by organ to donorid
	mapping by organ to hospital
	mapping by donor to hospital

	for future donation change boolean to true , add hopsital details

	purchase organ time limit if hospital doesn't acknowledge within ten days make it available again

	front-end

	later: 
		hospital schema: 
    	address
    	organs
    	accept method
	
	
*/