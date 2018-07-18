pragma solidity ^0.4.23;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

/**

* @title Organ Factory
* @dev TicketFactory is a contract for managing the token ownership,
* allowing the participants to purchase NFT with ether.
* @author Vinayak Shrivastava
   
*/

contract OrganFactory {

    using SafeMath for uint;

	struct Organ {
		string name;
		address donorId;
		uint256 refcode;
		uint256 hospitalId;
        string blood_group;
		bool isPurchased;
        address purchaser_id;
	}

    // import user schema

	Organ[] public organs;

	/* Events */
	event OrganDonated(/**/); // params to be decided

	/* Mappings */
	
    // Mapping from organ id to hospital
    mapping (uint => address) private organToHospital;
    // Mapping from user to owned organs
    mapping (address => uint256[]) private ownedOrgans;

    function donateOrgan( 
    	string _name,
    	address _donorId,
    	uint256 _refcode,
		uint256 _hospitalId,
        string blood_group,
		bool _isPurchased,
        address purchase_organ
    ) public returns (uint256) {
    	uint id = organs.push(Organ(_name,_donorId,
                                    _refcode,_hospitalId,
                                    blood_group,
                                    _isPurchased,purchase_organ)) - 1; // by default _isPurchased will be false and purchase_id is empty
    	
        //emit OrganDonated(id); // decide params
        
        return id;
    }

    /**
		@dev Get organ details
		
    */

    function getOrgan(uint256 _id) public view 
    returns(
    	string,
		address,
		uint256,
		uint256,
        string,
		bool,
        address
    ) {
    	return (
    		organs[_id].name,
    		organs[_id].donorId,
    		organs[_id].refcode,
    		organs[_id].hospitalId,
            organs[_id].blood_group,
    		organs[_id].isPurchased,
            organs[_id].purchaser_id
    	);
    }

    function getIsPurchased(uint256 _id) public view returns (bool) {
        return organs[_id].isPurchased;
    }

    function setIsPurchased(uint256 _id, bool _isPurchased) public {
        organs[_id].isPurchased = _isPurchased;
    }

    function purchase(uint256 _id,address _buyer) public returns (bool) {
        // check for black listed users if blacklisted return false
        
        organs[_id].purchaser_id = _buyer;
        
        // emit OrganDonated() 
        
        return true;        
    } 

    function purchaseOrgan(uint256 _id,address _buyer) public returns (uint256) {
        
        Organ storage organInstance = organs[_id];
        
        // pass token from one add to another and set isPurchased->true

        setIsPurchased(_id,true);
        purchase(_id,_buyer);
        return _id;

    }

    // function getPurchasedOrgans(address _buyer) public returns (bool) {
        
    //     return true;
    // }

}

