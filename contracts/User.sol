pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract User {

  using SafeMath for uint;

  struct Receiver {
    string name;
    address receiverId;
  }

  Receiver[] public receivers;
  event organApplied (
      bool success
    );

  mapping(address => string) public receiverToOrgan;

  function applyForOrgan(string _organName) public returns (bool success) {
    /* receiverToOrgan[msg.sender] = _organName; */
    /* emit organApplied(true); */
    return true;
  }

}
