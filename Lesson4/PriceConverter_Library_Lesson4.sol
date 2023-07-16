// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // using npm package to import interface

// creating a library

library PriceConverter{
    function getPrice() internal view returns(uint256){
        // to call a contract we need Address and an ABI
        // 0x694AA1769357215DE4FAC081bf1f309aDC325306 (address of contract on sepolia)
        int256 price;
        (,price,,,) = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).latestRoundData();
        // 193200000000 
        return uint256(price * 1e10);
    }
    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
      uint256 ethePrice = getPrice();
      uint256 ethAmountInUsd = (ethePrice * ethAmount)/1e18;
      return ethAmountInUsd;
    }
}