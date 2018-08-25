pragma solidity ^0.4.24;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract OrganFactory { // OrganFactory Contract

  using SafeMath for uint;

	struct Organ { // organ structure
		string name;
		address donorId;
		address hospitalId;
		bool isPurchased;
    address purchaser_id;
    bool isApproved;
  }


  Organ[] public organs;

/* Events */

  event OrganCreated(address indexed donorId);

  event OrganDonated(uint256 id);

/* Mapping */
  mapping (address => uint256[]) private ownedOrgans;
  /* mapping (address => Organ[]) private currentOwnerTo */


mapping (address => uint256[]) public organToHospital;
function donateOrgan( // Approve Organ
    	string _name,
    	address _donorId,
  	  address _hospitalId,
  	  bool _isPurchased,
      address _purchaser_id,
      bool _isApproved
    ) public returns (uint256) {

  	uint id = organs.push(Organ(_name,_donorId,
                                  _hospitalId,
                                  _isPurchased,_purchaser_id,_isApproved)) - 1;

    emit OrganCreated(_donorId);

    organToHospital[_hospitalId].push(id);

    return id;

}

function getOrgan(uint256 _id) public view // get organ by Id
    returns(
    	string,
    	address,
    	address,
    	bool,
      address,
      bool
    ) {
    	return (
    		organs[_id].name,
    		organs[_id].donorId,
    		organs[_id].hospitalId,
    		organs[_id].isPurchased,
        organs[_id].purchaser_id,
        organs[_id].isApproved
    	);
 }

  function getIsPurchased(uint256 _id) public view returns (bool) { // return purchase status of organ
      return organs[_id].isPurchased;
  }

  function setIsPurchased(uint256 _id, bool _isPurchased) public { // set purchase status of organ
      organs[_id].isPurchased = _isPurchased;
  }

  function purchase(uint256 _id,address _buyer) public returns (bool) { // set buyer of organ
      organs[_id].purchaser_id = _buyer;
      return true;
  }

  function purchaseOrgan(uint256 _id,address _buyer) public returns (uint256) { // purchase an organ and change purchase status and buyer details

      setIsPurchased(_id,true);
      purchase(_id,_buyer);
      ownedOrgans[_buyer].push(_id);
      emit OrganDonated(_id);
      return _id;
  }

  function getCount() public view returns (uint256) { // return array length of organs
    return organs.length;
  }

  function getUserOrgans(address _owner) public view returns (uint256[]) {
    return ownedOrgans[_owner];
  }

}
