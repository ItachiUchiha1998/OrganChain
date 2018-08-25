pragma solidity ^0.4.24;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract OrganFactory { // OrganFactory Contract

  using SafeMath for uint;

	struct Organ { // organ structure
		bytes32 name;
		address donorId;
		address hospitalId;
		bool isReceived;
    address receiver_id;
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
    	bytes32 _name,
    	address _donorId,
  	  address _hospitalId,
  	  bool _isReceived,
      address _receiver_id,
      bool _isApproved
    ) public returns (uint256) {

  	uint id = organs.push(Organ(_name,_donorId,
                                  _hospitalId,
                                  _isReceived,_receiver_id,_isApproved)) - 1;

    emit OrganCreated(_donorId);

    organToHospital[_hospitalId].push(id);

    return id;

}

function getOrgan(uint256 _id) public view // get organ by Id
    returns(
    	bytes32,
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
    		organs[_id].isReceived,
        organs[_id].receiver_id,
        organs[_id].isApproved
    	);
 }

  function getIsReceived(uint256 _id) public view returns (bool) { // return receive status of organ
      return organs[_id].isReceived;
  }

  function setIsReceived(uint256 _id, bool _isReceived) public { // set Received status of organ
      organs[_id].isReceived = _isReceived;
  }

  function received(uint256 _id,address _receiver) public returns (bool) { // set receive of organ
      organs[_id].receiver_id = _receiver;
      return true;
  }

  function receiveOrgan(uint256 _id,address _receive) public returns (uint256) { // receive an organ and change receive status and buyer details

      setIsReceived(_id,true);
      received(_id,_receive);
      ownedOrgans[_receive].push(_id);
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
