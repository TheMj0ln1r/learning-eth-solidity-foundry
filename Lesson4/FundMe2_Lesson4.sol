// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // using npm package to import interface
//using library

import {PriceConverter} from "./PriceConverter_Lesson4.sol";


contract FundMe{
    // adding library access to all uint256
    using PriceConverter for uint256;

    uint256 public minUsd = 1* 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    function fund() public payable {

        require(msg.value.getConversionRate() >= minUsd,"Send at least 5 USD ");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;

    }
}
