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
  }

  struct Hospital { // hospital structure
    string name;
    address hospitalId;
    uint256[] approvRequest;
    uint256[] approved;
  }
  Hospital[] public hospitals;

function createHospital(string _name,address hospitalId) public returns (bool){ // create hospital
  hospitals.push(Hospital(_name,hospitalId, new uint256[](0), new uint256[](0)));
  return true;
}

  Organ[] public organs;

  /* Events */
	event OrganCreated(address indexed donorId, uint256 indexed refcode); 
  event OrganApproved(); 
  event OrganRejected();   
  event OrganDonated(uint256 id);

  /* Mapping */
  mapping (uint => address) private organToHospital;
  mapping (address => uint256[]) private ownedOrgans;

  function organAccepted(uint _i, uint _j) public returns(bool){ // Approve Organ
    //_i is index in hospital array
    //_j is the index in approvRequest array
    uint256 k = hospitals[_i].approvRequest[_j];
    hospitals[_i].approved.push(k);
    for(uint i=_j; i<hospitals[_i].approvRequest.length-1;i++) {
      hospitals[_i].approvRequest[i] = hospitals[_i].approvRequest[i+1];
    }
    delete hospitals[_i].approvRequest[hospitals[_i].approvRequest.length-1];
    hospitals[_i].approvRequest.length--;
    emit OrganApproved();
    return true;
  }

  function organRejected(uint _i, uint _j) public returns(bool){ // DisApprove a Organ

    for(uint i=_j; i<hospitals[_i].approvRequest.length-1;i++) {
      hospitals[_i].approvRequest[i] = hospitals[_i].approvRequest[i+1];
    }
    delete hospitals[_i].approvRequest[hospitals[_i].approvRequest.length-1];
    hospitals[_i].approvRequest.length--;
    emit OrganRejected();
    return false;
  }


  function see_function(address _hospitalId) public view returns (uint256[]) { // see approve requests
    for(uint i=0;i<hospitals.length;i++) {
        if(hospitals[i].hospitalId == _hospitalId) {
          return hospitals[i].approvRequest;
      }
    }
  }

  function donateOrgan( // Approve Organ
  	string _name,
  	address _donorId,   
  	uint256 _refcode,
	  address _hospitalId, 
	  bool _isPurchased,
    address _purchaser_id
  ) public returns (uint256) {

  	uint id = organs.push(Organ(_name,_donorId,
                                  _refcode,_hospitalId,
                                  _isPurchased,_purchaser_id)) - 1; 

    emit OrganCreated(_donorId , _refcode);

    for(uint i=0;i<hospitals.length;i++) { // send approve request to hospital
        if(hospitals[i].hospitalId == _hospitalId) {
          hospitals[i].approvRequest.push(uint256(keccak256(abi.encodePacked(_name,_hospitalId))))-1;
        }
      }
   
    return id;
  
  }

  function getOrgan(uint256 _id) public view // get organ by Id
    returns(
    	string,
    	address,
    	uint256,
    	address,
    	bool,
      address
    ) {
    	return (
    		organs[_id].name,
    		organs[_id].donorId,
    		organs[_id].refcode,
    		organs[_id].hospitalId,
    		organs[_id].isPurchased,
        organs[_id].purchaser_id
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


/* 
  all functions executable
*/