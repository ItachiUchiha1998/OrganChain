pragma solidity ^0.4.23;
/**
* @title Organ Factory
* @dev TicketFactory is a contract for managing the token ownership,
* allowing the participants to purchase NFT with ether.
* @author Vinayak Shrivastava

*/

/* import "github.com/Arachnid/solidity-stringutils/strings.sol"; */
contract OrganFactory {

 /* using strings for *; */
	struct Organ {
		string name;
		string bloodType;
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
    	string _bloodType,
    	uint256 _donorId,
    	uint256 _refcode,
		uint256 _hospitalId,
		bool _isPurchased
    ) public returns (uint256) {
    	uint id = organs.push(Organ(_name,_bloodType,_refcode,_donorId,_hospitalId,_isPurchased)) - 1; // by default _isPurchased will be false
    	//emit OrganDonated(id); // decide params
        return id;
    }

    /**
		@dev Get organ details

    */

    function getOrgan(uint256 _id) public view
    returns(
    	string,
		uint256,
		uint256,
		uint256,
		bool
    ) {
    	return (
    		organs[_id].name,
    		organs[_id].donorId,
    		organs[_id].refcode,
    		organs[_id].hospitalId,
    		organs[_id].isPurchased
    	);
    }

    function getIsPurchased(uint256 _id) public view returns (bool) {
        return organs[_id].isPurchased;
    }

    function setIsPurchased(uint256 _id, bool _isPurchased) public {
        organs[_id].isPurchased = _isPurchased;
    }

    // if (stringu.equal("aman","signed")) {}

// var len = "Unicode snowman ☃".toSlice().len();
}
