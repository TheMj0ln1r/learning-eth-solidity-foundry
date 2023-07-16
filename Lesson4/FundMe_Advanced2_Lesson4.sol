// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//constants and immutable
//custom errors in place of require

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // using npm package to import interface

//using library

import {PriceConverter} from "./PriceConverter_Lesson4.sol";

error NotOwner();
error SendFailed();
error SendAtleast();
contract FundMe{
    // adding library access to all uint256
    using PriceConverter for uint256;

    uint256 public constant MIN_USD = 1* 1e18; // gas efficient
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner; // wont changeable once assigned
    
    constructor(){
      i_owner = msg.sender; 
    }

    function fund() public payable {

        if (msg.value.getConversionRate() < MIN_USD){
          revert SendAtleast();
        }
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;

    }
    function withdraw() public onlyOwner{ // invoking mofidifier
      // or we can use the modifier inplace of above line

      //for loop
      for(uint256 funderIndex= 0; funderIndex < funders.length; funderIndex++){
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
      }
      // resetting funders array
      funders = new address[](0);
      //withdrawing ways
        // transfer
        // send
        // call
    // call  --> lower level EVM function
      // call can be used to call the functions, for now its empty("").
      // it returns two values, a bool and data returned by the funtion call
      (bool callSuccess, /*bytes memory dataReturned*/) = payable(msg.sender).call{value: address(this).balance}("");
      if(!callSuccess){revert SendFailed();}
    }

    modifier onlyOwner(){
      if(msg.sender != i_owner){revert NotOwner();}
      _;
    }

    //revert() can be used in any function call
}