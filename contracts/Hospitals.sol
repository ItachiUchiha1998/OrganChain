pragma solidity ^0.4.24;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./OrganFactory.sol";
import "./User.sol";


contract Hospitals is OrganFactory,User {

  using SafeMath for uint;

  struct Hospital { // hospital structure
    string name;
    address hospitalId;
  }

Hospital[] public hospitals;

event OrganApproved(uint256 id);
event OrganRejected(uint256 id);



function createHospital(string _name) public returns (bool success){ // create hospital
  hospitals.push(Hospital(_name,msg.sender));
  return true;
}

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

function set_priority(uint256 _receiver,uint256 priority_order) public returns (bool) {
    receivers[_receiver].priority.push(priority_order);
    return true;
  }

function organ_max_priority(uint256 _id) public  returns(bool) {

  uint256 max_priority = 0;
  uint256 temp = 0;
  for(uint256 i =0; i<receivers.length;i++) {

    /* if(keccak256(receiverToOrgan[receivers[i].receiverId]) == keccak256(organs[_id].name)) { */
    if(receiverToOrgan[receivers[i].receiverId] == organs[_id].name) {
      if(receivers[i].meanPriority > max_priority) {
        max_priority = receivers[i].meanPriority;
        temp = i;
      }
    }
  }
  organs[_id].purchaser_id = receivers[temp].receiverId; 
  organs[_id].isPurchased = true;
  return true;
}

}
