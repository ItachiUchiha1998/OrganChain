pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract User {

  using SafeMath for uint;

  struct Receiver {
    string organname;
    address receiverId;
    uint256[] priority;
    uint256 meanPriority; 
  }

  Receiver[] public receivers;

  event organApplied (bool success);
  event receiverCreated (uint256 _id);

  mapping(address => string) public receiverToOrgan;

  function createReceiver(string _organ) public returns (uint256) {
    uint256 id = receivers.push(Receiver(_organ,0)) - 1;
    receiverCreated(id);  
    return id;
  }

  function applyForOrgan(string _organName) public returns (bool success) {
    receiverToOrgan[msg.sender] = _organName;
    emit organApplied(true);
    return true;
  }

}
