pragma solidity ^0.4.19;

/**
* @title Organ Factory
* @dev TicketFactory is a contract for managing the token ownership,
* allowing the participants to purchase NFT with ether.
* @author Vinayak Shrivastava
*/

contract OrganFactory {

	struct Organ {
		string name;
		uint256 donorId;
		uint256 refcode;
		uint256 hospitalId;
		bool isPurchased;
	}

	Organ[] public organs;

	/* Events */
	event OrganDonated(/**/); // params to be decided

	/* Mappings */
	// Mapping from organ id to hospital
    mapping (uint => address) private organToHospital;
    // Mapping from user to owned organs
    mapping (address => uint256[]) private ownedOrgans;


    /**
	*	@dev Donate an organ and push into the blockchain	
    */
    function donateOrgan( 
    	string _name,
    	uint256 _donorId,
    	uint256 _refcode,
		uint256 _hospitalId,
		bool _isPurchased
    ) public returns (uint256) {
    	uint id = organs.push(Organ(_name,_refcode,_donorId,_hospitalId,_isPurchased)) - 1; // by default _isPurchased will be false
    	//emit OrganDonated(id); // decide params
        return id;
    }

}
