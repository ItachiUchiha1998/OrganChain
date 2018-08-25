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

  mapping(address => string) public receiverToOrgan;

  function createReceiver(address _receiver) public returns (bool success) {
    uint256 id = receivers.push(Receiver(_receiver,new uint256[](0),0)) - 1;
    emit receiverCreated(id);
    return true;
  }

  function applyForOrgan(string _organName) public returns (bool success) {
    receiverToOrgan[msg.sender] = _organName;
    emit organApplied(true);
    return true;
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
