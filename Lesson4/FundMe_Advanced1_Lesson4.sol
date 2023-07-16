// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // using npm package to import interface

//using library

import {PriceConverter} from "./PriceConverter_Lesson4.sol";


contract FundMe{
    // adding library access to all uint256
    using PriceConverter for uint256;

    uint256 public minUsd = 5* 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // constructor will be called immediately after deployment of contract

    address public owner;
    constructor(){
      minUsd = 1 * 1e18;
      owner = msg.sender; 
    }

    function fund() public payable {

        require(msg.value.getConversionRate() >= minUsd,"Send at least 5 USD ");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;

    }
    function withdraw() public onlyOwner{ // invoking mofidifier
      // requre(msg.sender == owner,"Only Owner can withdraw");
      // or we can use the modifier inplace of above line

      //for loop
      for(uint256 funderIndex= 0; funderIndex < funders.length; funderIndex++){
        address funder = funders[funderIndex];
        // making funds to 0 in the mapping
        addressToAmountFunded[funder] = 0;
      }
      // resetting funders array
      funders = new address[](0);
      //withdrawing ways
        // transfer
        // send
        // call
      
    // transfer --> if gasLimit exceeds 2300, throws an error and reverts automatically
      // msg.sender = address
      // payable(msg.sender) = payable address
      //payable(msg.sender).transfer(address(this).balance);

    // send  --> if gasLimit exceeds 2300 or not, returns a bool
      //bool sendSuccess = payable(msg.sender).send(address(this).balance);
      // returns true if success
      //require(sendSuccess,"send failed");
    
    // call  --> lower level EVM function
      // call can be used to call the functions, for now its empty("").
      // it returns two values, a bool and data returned by the funtion call
      (bool callSuccess, /*bytes memory dataReturned*/) = payable(msg.sender).call{value: address(this).balance}("");
      require(callSuccess, "Send failed");
    }

    modifier onlyOwner(){
      //_; execude the code in the function first and then require
      require(msg.sender == owner, "Only onwer can withdraw");
      _;// execude the code in the function after above line
    }


}