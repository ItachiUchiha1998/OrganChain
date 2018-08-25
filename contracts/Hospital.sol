pragma solidity ^0.4.24;
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./OrganFactory.sol";

contract Hospital {

  using SafeMath for uint;

  struct HospitalContract { // hospital structure
    string name;
    address hospitalId;
  }

  HospitalContract[] public hospitals;

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

  function see_function() public view returns (uint256[]) { // see approve requests
      return organToHospital[msg.sender];
  }

  function set_priority(address _receiver) public returns (bool) {

    return true;
  }
  

}
