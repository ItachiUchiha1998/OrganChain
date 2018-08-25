pragma solidity ^0.4.24;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./OrganFactory.sol";

contract Hospitals is OrganFactory {

  using SafeMath for uint;

  struct Hospital { // hospital structure
    string name;
    address hospitalId;
  }

Hospital[] public hospitals;

event OrganApproved(uint256 id);
event OrganRejected(uint256 id);

  mapping (address => uint256[]) private organToHospital;

function createHospital(string _name) public returns (bool success){ // create hospital
  hospitals.push(Hospital(_name,msg.sender));
  emit OrganApproved(1);
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

function see_function() public view returns (uint256[]) { // see approve requests
    return organToHospital[msg.sender];
}

}
