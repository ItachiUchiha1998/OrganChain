pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "./Hospitals.sol";

contract User is Hospitals{

  using SafeMath for uint;

  struct Receiver {
    address receiverId;
    uint256[1000] priority;
    uint256 meanPriority;
  }

  Receiver[] public receivers;

  event organApplied (bool success);
  event receiverCreated (uint256 _id);

  mapping(address => string) public receiverToOrgan;

  function createReceiver() public returns (uint256) {
    uint256 id = receivers.push(Receiver(msg.sender,new uint256[][0],0)) - 1;
    receiverCreated(id);
    return id;
  }

  function applyForOrgan(string _organName) public returns (bool success) {
    receiverToOrgan[msg.sender] = _organName;

    emit organApplied(true);
    return true;
  }

}
