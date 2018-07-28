pragma solidity ^0.4.24;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract OrganFactory { // OrganFactory Contract

  using SafeMath for uint;

	struct Organ { // organ structure
		string name;
		address donorId;
		uint256 refcode;
		address hospitalId;
		bool isPurchased;
    address purchaser_id;
    bool isApproved;
  }

  struct Hospital { // hospital structure
    string name;
    address hospitalId;
    uint256[] approved;
  }
  Hospital[] public hospitals;

function createHospital(string _name,address hospitalId) public returns (bool){ // create hospital
  hospitals.push(Hospital(_name,hospitalId, new uint256[](0)));
  return true;
}

  Organ[] public organs;

/* Events */
	
  event OrganCreated(address indexed donorId, uint256 indexed refcode); 
  event OrganApproved(uint256 id); 
  event OrganRejected(uint256 id);   
  event OrganDonated(uint256 id);

/* Mapping */
  mapping (address => uint256[]) private organToHospital;
  mapping (address => uint256[]) private ownedOrgans;

function acceptOrgan(uint256 _id) public returns (bool) { // approve a organ donation
    organs[_id].isApproved = true;
    emit OrganApproved(_id);
    return true;
}

function rejectOrgan(uint256 _id) public returns (bool) { // reject organ donation
    organs[_id].isApproved = false;
    emit OrganRejected(_id);
    return true;
}

function see_function(address _hospitalId) public view returns (uint256[]) { // see approve requests
    return organToHospital[_hospitalId];
}

function donateOrgan( // Approve Organ
    	string _name,
    	address _donorId,   
    	uint256 _refcode,
  	  address _hospitalId, 
  	  bool _isPurchased,
      address _purchaser_id,
      bool _isApproved
    ) public returns (uint256) {

  	uint id = organs.push(Organ(_name,_donorId,
                                  _refcode,_hospitalId,
                                  _isPurchased,_purchaser_id,_isApproved)) - 1; 

    emit OrganCreated(_donorId , _refcode);

    organToHospital[_hospitalId].push(id);
   
    return id;
  
}

function getOrgan(uint256 _id) public view // get organ by Id
    returns(
    	string,
    	address,
    	uint256,
    	address,
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
