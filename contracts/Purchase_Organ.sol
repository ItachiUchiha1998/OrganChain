pragma solidity ^0.4.23;

import "./OrganFactory.sol";

// i.e now wehave an array of structs named organ \
// which contains donated organs list
contract PurchaseOrgan is OrganFactory {
//Contract which will deal with purchasing of organs
//mapping buyer is compatible with which bloodType
struct DonorBlood {
  string[] blood;
}
mapping(string => DonorBlood) bloodCompatible;

constructor() public {
bloodCompatible['O'].blood[0] = 'O';
bloodCompatible['A'].blood[0] = 'A';
bloodCompatible['A'].blood[1] = 'O';
bloodCompatible['B'].blood[0] = 'B';
bloodCompatible['B'].blood[1] = 'O';
bloodCompatible['AB'].blood[0] = 'A';
bloodCompatible['AB'].blood[1] = 'B';
bloodCompatible['AB'].blood[2] = 'AB';
bloodCompatible['AB'].blood[3] = 'O';
}
struct AvailOrgan {
  string name;
  uint256 donorId;
  uint256 refcode;
  uint256 hospitalId;
  bool isPurchased;
}
// List of available organs having compatible bloodType
AvailOrgan[] public availorgans;

// Buyable Organ -- input buyer's id, organRequired, bloodType
// Buyable Organ -- output struct of type AvailOrgan
function buyableOrgan(uint256 _id, string _organRequired, string _bloodType) public view returns(bool)
{

  for(uint i=0; i < organs.length; i++) {
    if(keccak256(organs[i].name) == keccak256(_organRequired)) {
      uint len = bloodCompatible[_bloodType].blood.length;
      for(uint j=0; j< len; j++) {
        if(keccak256(organs[i].bloodType) == keccak256(bloodCompatible[_bloodType].blood[j])) {
          availorgans.push(AvailOrgan(organs[i].name, organs[i].donorId, organs[i].refcode, organs[i].hospitalId, organs[i].isPurchased)) - 1;
        }
      }
    }
  }
  return true;
}



}
