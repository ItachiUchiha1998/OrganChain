pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract User{

  using SafeMath for uint;

  struct Receiver {
    address receiverId;
    uint256[] priority;
    uint256 meanPriority;
  }

  Receiver[] public receivers;

  event organApplied (bool success);
  event receiverCreated (uint256 _id);

  mapping(address => bytes32) public receiverToOrgan;

  function createReceiver(address _receiver) public returns (bool success) {
    uint256 id = receivers.push(Receiver(_receiver,new uint256[](0),0)) - 1;
    emit receiverCreated(id);
    return true;
  }

  function applyForOrgan(bytes32 _organName) public returns (bool success) {
    receiverToOrgan[msg.sender] = _organName;
    emit organApplied(true);
    return true;
  }

  function getReceivers(uint256 _id) public view // get organ by Id
    returns(address,uint256) {
      return (
        receivers[_id].receiverId,
        receivers[_id].meanPriority
      );
 }
 function getCount() public view returns (uint256) { // return array length of receivers
    return receivers.length;
  }

  function getAppliedOrgan(address _receiver) public view returns (bytes32) {
    return receiverToOrgan[_receiver];
  }

  function  mean_priority(uint256 _id) public returns (bool) {
    uint256 m = 0;
    for(uint256 i=0;i<receivers[_id].priority.length;i++) {
      m = m + i;
    }
    uint256 p = m/receivers[_id].priority.length;
    receivers[_id].meanPriority = p;
  }

}
