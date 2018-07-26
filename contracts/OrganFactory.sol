pragma solidity ^0.4.24;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract OrganFactory {

  using SafeMath for uint;

	struct Organ {
		string name;
		address donorId;
		uint256 refcode;
		address hospitalId;
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

function createHospital(string _name,address hospitalId) public returns (bool){
  hospitals.push(Hospital(_name,hospitalId, new uint256[](0), new uint256[](0)));
  return true;
}

  Organ[] public organs;

	event OrganDonated(/**/); // params to be decided

    mapping (uint => address) private organToHospital;
    mapping (address => uint256[]) private ownedOrgans;

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

    function organRejected(uint _i, uint _j) public returns(bool){

      for(uint i=_j; i<hospitals[_i].approvRequest.length-1;i++) {
        hospitals[_i].approvRequest[i] = hospitals[_i].approvRequest[i+1];
      }
      delete hospitals[_i].approvRequest[hospitals[_i].approvRequest.length-1];
      hospitals[_i].approvRequest.length--;
      return false;
    }


function see_function(address _hospitalId) public view returns (uint256[]) {
for(uint i=0;i<hospitals.length;i++) {
        if(hospitals[i].hospitalId == msg.sender) {
          return hospitals[i].approvRequest;
        }
      }
    }

    function donateOrgan(
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
        for(uint i=0;i<hospitals.length;i++) {
          if(hospitals[i].hospitalId == _hospitalId) {
            uint256 j = hospitals[i].approvRequest.push(uint256(keccak256(abi.encodePacked(_name,msg.sender))))-1;
          }
          else {

          }
        }
      return id;
    }

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

    // function getHospital(uint256 _id) public view
    // returns(
    //   string,
    // address,
    // uint256[],
    // uint256[]  ) {
    //   return (        hospitals[_id].name,
    //     hospitals[_id].hospitalId,
    //     hospitals[_id].approvRequest,
    //     hospitals[_id].approved,
    //   );
    // }

    function getIsPurchased(uint256 _id) public view returns (bool) {
        return organs[_id].isPurchased;
    }

    function setIsPurchased(uint256 _id, bool _isPurchased) public {
        organs[_id].isPurchased = _isPurchased;
    }

    function purchase(uint256 _id,address _buyer) public returns (bool) {
        organs[_id].purchaser_id = _buyer;
        return true;
    }

    function purchaseOrgan(uint256 _id,address _buyer) public returns (uint256) {

        Organ storage organInstance = organs[_id];
        setIsPurchased(_id,true);
        purchase(_id,_buyer);
        return _id;
    }

    function getCount() public view returns (uint256) {
      return organs.length;
    }

}
