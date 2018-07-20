pragma solidity ^0.4.24;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

/**

* @title Organ Factory
* @dev TicketFactory is a contract for managing the token ownership,
* allowing the participants to purchase NFT with ether.
* @author Vinayak Shrivastava

*/

/* import "github.com/Arachnid/solidity-stringutils/strings.sol"; */
contract OrganFactory {

    using SafeMath for uint;

	struct Organ {
		string name;
		address donorId;
		uint256 refcode;
		uint256 hospitalId;
    /* string blood_group; */
		bool isPurchased;
    address purchaser_id;
    bool isApproved; // For organ approval by hospital
  }

  struct Hospital {
    string name;
    uint256[] approvRequest;
    uint256[] approved;
  }
  Hospital[] public hospitals;

// function takes string as input which will contain address of hospital
function createHospital(string _name) public {
  hospitals.push(Hospital(_name, new uint256[](0), new uint256[](0)));//,uint256[], uint256[]));
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



    /* function getApproval(uint256 _hospitalId, string _name, uint256 _donorId) public returns (bool){
      for(uint i=0;i<hospitals.length;i++) {
        if(hospitals[i].hospitalId == _hospitalId) {
          hospitals[i].approvRequest.push(keccak256(_name,_donorId));

        }
      }
    } */

    function donateOrgan(
    	string _name,
    	address _donorId,
    	uint256 _refcode,
		  uint256 _hospitalId,
        /* string blood_group, */
		  bool _isPurchased,
      address _purchaser_id, // address of the per
      bool _isApproved
    ) public returns (uint256) {

      /* if(!_isApproved) {
        getApproval(_hospitalId, _name, _donorId);
      } */
    	uint id = organs.push(Organ(_name,_donorId,
                                    _refcode,_hospitalId,
                                    _isPurchased,_purchaser_id,_isApproved)) - 1; // by default _isPurchased will be false and purchaser_id is empty */

        /* //emit OrganDonated(id); // decide params*/
        return id;
    }

    /**
		@dev Get organ details input - block id

    */

    function getOrgan(uint256 _id) public view
    returns(
    	string,
		address,
		uint256,
		uint256,
		bool,
    address,
    bool
    ) {
    	return (
    		organs[_id].name,
    		organs[_id].donorId,
    		organs[_id].refcode,
    		organs[_id].hospitalId,
    		organs[_id].isPurchased,
            organs[_id].purchaser_id,
        organs[_id].isApproved
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
