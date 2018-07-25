import "../stylesheets/app.css";

import { default as Web3} from 'web3';
import { default as contract } from 'truffle-contract';
import organ_artifacts from '../../build/contracts/OrganFactory.json';

  $(document).ready(function(){

     if (typeof web3 !== 'undefined') {
      console.warn("External")
      window.web3 = new Web3(web3.currentProvider);
    } else {
      console.warn("No web3 detected");
      window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
    }

  var Organ = contract(organ_artifacts);

    Organ.setProvider(web3.currentProvider);

  function donateOrgan() {
  
    console.log("donate organ function called")

    let organName = $('#organName').val();
    let hospitalId = $('#hospitalId').val();
    let refcode = $('#refcode').val();
    let donorId = web3.eth.accounts[0];
    
    try{
      
      Organ.deployed().then(function(contractInstance) {
      
        contractInstance.donateOrgan(organName,donorId,refcode,
                                     hospitalId,false,"0x0",
                                    {gas:10000,from:web3.eth.accounts[0]})
        .then(function(){
          return true;
        })
      })

    } catch(err) {
      console.log(err);
    }

  }
    $("#donate").click(donateOrgan);
        
  })

  // getOrgan = function(organ) {
    
  //   try {
  //     Organ.deployed().then(function(contractInstance) {
  //         contractInstance.getOrgan.call(id).then(function(v) {
  //           console.log(v.toString());
  //         });
  //       })
  //   } catch(err) {
  //     console.log(err);
  //   }
  // } 

  // test = function(hospital) {

  //   console.log("test function called")
    
  // }

  // createHospital = function(hospital){
  //   console.log("create hospital function called")

  //   let hospitalName = $('#hospitalName').val()
    
  //   try{
      
  //     Organ.deployed().then(function(contractInstance) {
      
  //       contractInstance.createHospital(hospitalName,web3.eth.account[1],
  //                                   {gas:10000,from:web3.eth.account[1]})
  //       .then(function(){
  //         return true;
  //       })
  //     })

  //   } catch(err) {
  //     console.log(err);
  //   }

  // }

  // getHospital = function(hospital) {
    
  //   let id = web3.eth.account[1];

  //   try {

  //     Organ.deployed().then(function(contractInstance){
  //       contractInstance.see_function.call(id).then(function(v) {
  //         console.log(v.toString())
  //       })
  //     })

  //   } catch(err) {
  //     console.log(err);
  //   }
  // }

  // purchaseOrgan = function(purchase) {
  //   let id = 1;
  //   try {
  //     Organ.deployed().then(function(contractInstance) {
  //       contractInstance.purchaseOrgan(id,web3.eth.account[0],{gas:10000,from:web3.eth.account[1]})
  //     })
  //   } catch(err) {
  //     console.log(err)
  //   }
  // }