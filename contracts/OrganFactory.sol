pragma solidity ^0.4.24;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract OrganFactory {

  using SafeMath for uint;

	struct Organ {
		string name;
		address donorId;
		uint256 refcode;
		address hospitalId;
    /* string blood_group; */
		bool isPurchased;
    address purchaser_id;
  }

  struct Hospital {
    string name;
    address hospitalId;
    uint256[] approvRequest;
    uint256[] approved;
  }
  Hospital[] public hospitals;

// function takes string as input which will contain address of hospital
function createHospital(string _name) public returns (uint256){
  hospitals.push(Hospital(_name,msg.sender, new uint256[](0), new uint256[](0)));
  // event
  return msg.sender;
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

//This function will be called via button from fronend when organ accepted
    function organAccepted(uint _i, uint _j) public returns(bool){
      //_i is index in hospital array
      //_j is the index in approvRequest array
      uint256 k = hospitals[_i].approvRequest[_j];
      hospitals[_i].approved.push(k);
      for(uint i=_j; i<hospitals[_i].approvRequest.length-1;i++) {
        hospitals[_i].approvRequest[i] = hospitals[_i].approvRequest[i+1];
      }
      delete hospitals[_i].approvRequest[hospitals[_i].approvRequest.length-1];
      hospitals[_i].approvRequest.length--;
      return true;
    }
//Function will be called via button from frontend when organ is rejected
    function organRejected(uint _i, uint _j) public returns(bool){

      for(uint i=_j; i<hospitals[_i].approvRequest.length-1;i++) {
        hospitals[_i].approvRequest[i] = hospitals[_i].approvRequest[i+1];
      }
      delete hospitals[_i].approvRequest[hospitals[_i].approvRequest.length-1];
      hospitals[_i].approvRequest.length--;
      return false;
    }

    /* function getApproval(address _hospitalId, string _name, address _donorId) public returns (bool){
      for(uint i=0;i<hospitals.length;i++) {
        if(hospitals[i].hospitalId == _hospitalId) {
          uint256 j = hospitals[i].approvRequest.push(uint256(keccak256(abi.encodePacked(_name,_donorId))))-1;
          //Since push command finds the length
          return true;
        }
      }
    } */

<<<<<<< HEAD
    function see_function(address _hospitalId) public view returns (uint256[]) {
=======
    function see_function() public returns (uint256[]) {
>>>>>>> 345ab13fdfbaab2f00f8e045fc2d65cfbdfaaa61
      for(uint i=0;i<hospitals.length;i++) {
        if(hospitals[i].hospitalId == msg.sender) {
          return hospitals[i].approvRequest;
        }
      }
    }

    function donateOrgan(
    	string _name,
    	/* address _donorId, */  // since donor id is same as msg.sender
    	uint256 _refcode,
		  address _hospitalId, // Imp -- will be found fromm create hospital
        /* string blood_group, */
		  bool _isPurchased,
      address _purchaser_id// address of the per
    ) public returns (uint256) {

    	uint id = organs.push(Organ(_name,msg.sender,
                                    _refcode,_hospitalId,
                                    _isPurchased,_purchaser_id)) - 1; // by default _isPurchased will be false and purchaser_id is empty */

        /* //emit OrganDonated(id); // decide params*/
        for(uint i=0;i<hospitals.length;i++) {
          if(hospitals[i].hospitalId == _hospitalId) {
            uint256 j = hospitals[i].approvRequest.push(uint256(keccak256(abi.encodePacked(_name,msg.sender))))-1;
          }
          else {
            // raise error
          }
        }
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
