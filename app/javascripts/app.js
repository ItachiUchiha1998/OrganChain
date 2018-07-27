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
                                     hospitalId,false,"0x0",false,
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
            $('#organs').html('')
            for(let i=1;i<=v;i++)    
            contractInstance.getOrgan.call(i-1).then(function(v){

              var stat = "";

              if(v[5] == false) {
                console.log("available");
                stat = `<button id="getOrgan" class="waves-effect waves-light btn">Get Organ</button>
              `;
              } else {
                stat = `<button id="status" class="waves-effect waves-light btn">Purchased</button>`;
              }

              $('#organs').append(
    `<div class="row">
        <div class="col s12">
          <div class="card " style="background-color: #fb576a">
            <div class="card-content white-text" >
              <span class="card-title">` + v[0] +`</span>
              <p>ReferenceID : ` + v[2] + `</p>
              <p>Organ Id: <span id="organId">` +(i-1) + `</span></p>
            </div>
            <div class="card-action ">
            `+stat+`
              
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

  function getMyOrgans() {
    console.log("get user organs");
    try {
      Organ.deployed().then(function(contractInstance) {
          contractInstance.getUserOrgans.call(web3.eth.accounts).then(function(v) {
            
            console.log(v.toString())
            if (v.toString()=="") { 
              console.log("No organs"); 
              $('#myorgans').html('')
              $('#myorgans').append(`
                <h3 style="left:33%;position:relative">No Organs</h3>
              `) }
            else {
              contractInstance.getOrgan.call(v.toString()).then(function(v){
              console.log(v.toString())
              $('#myorgans').html('')
              $('#myorgans').append(
                `<div class="row">
                    <div class="col s12">
                      <div class="card " style="background-color: #fb576a">
                        <div class="card-content white-text" >
                          <span class="card-title">` + v[0] +`</span>
                          <p>ReferenceID : ` + v[2] + `</p>
                        </div>
                    </div>
                </div>`
                            )

            })
            }
            
          });
        })
    } catch(err) {
      console.log(err);
    }
  }
  
  $("#donate").click(donateOrgan);
  $('#get').click(getOrgan);
  $('#my').click(getMyOrgans);
  $('#organDonate').hide();
  $('#hospital').hide();
  $(document).on("click", '#getOrgan',function(){
    
    var organId = $('#organId').text();
    console.log("purchase function called for: " + organId )

    try {
      Organ.deployed().then(function(contractInstance) {
      
        contractInstance.purchaseOrgan(organId,web3.eth.accounts,
                                    {gas:10000,from:web3.eth.accounts[0]})
        .then(function(){
          return true;
        })
      })
    } catch(err) {
      console.log(err)
    }


  })

    $("#cancel").click(function(){
        $("#organDonate").hide();
    });

    $('#showHospital').click(function() {
      $('#main').hide();
      $('#hospital').show();
    })

    $('#homebutton').click(function() {
      $('#hospital').hide();
      $('#main').show();
    })

    $("#showDonate").click(function(){
        $("#organDonate").show();
    });
        
  })

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


/*
hospital approval
*/