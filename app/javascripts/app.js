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

  function getOrgan() {

    console.log("get organ function called")

    try {
      Organ.deployed().then(function(contractInstance) {
          contractInstance.getCount.call().then(function(v) {
            console.log(v.toString());

            for(let i=1;i<=v;i++)    
            contractInstance.getOrgan.call(i-1).then(function(v){
              $('#organs').append(
    `<div class="row">
        <div class="col s12">
          <div class="card " style="background-color: #fb576a">
            <div class="card-content white-text" >
              <span class="card-title">` + v[0] +`</span>
              <p>ReferenceID : ` + v[2] + `</p>
            </div>
            <div class="card-action">
              <button>Get Organ</button>
              </div>
          </div>
        </div>
    </div>`
                )
              console.log(v.toString())
            })
        
          });
        })
    } catch(err) {
      console.log(err);
    }
  }
  
  $("#donate").click(donateOrgan);
  $('#get').click(getOrgan);
        
  })

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
