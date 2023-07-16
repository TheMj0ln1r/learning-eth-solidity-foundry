// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//Interface to get the price details
/*
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}*/
//OR
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // using npm package to import interface


// Get funds from users
// withdraw funds

contract FundMe{
    // uint256 public myValue = 1;

    uint256 public minUsd = 1* 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    function fund() public payable {
        //allow users to send ETH
        // have a minimum ETH sent
        // there always a value field in the transaction
        // payable to recieve ETH
        // contracts holds ETH similiar to the way wallets holds
// setting minumum ether
        // msg.value --> number of wei recieved from transaction
        //myValue = myValue + 1;// if the require condition failed,this also will be reverted
        //require(msg.value >= 1e18, "Send atleast 1 ETH" );// 1e18 = 1 ETH = 1000000000000000000 = 1*10 ** 18 wei

        //revert, undo any actions that have been done and send the remaining gas back
        //failed transaction costs gas upto the failed part computation
        //gas payed for the rest of the computations will be refunded to sender

        // transaction components {to, from, gasPrice,gasLimit, Nonce, Data, v,r,s}

// setting minimum USD can a sender send to this contract
        // Blockchains are deterministic, they are unable to connect with external systems
        // If we include external source directly, It means again we introduced a centralized third-party
        // Blockchain oracle is a device that interacts with 
        // off-chain chain world
        // The oracle should be decentralized too
        // Chainlink is decentralized oracle network to connect smartc contracts with 
        // external system

        // Chainlink Verifiable Random number (VRF)
        // chainlink Automation(keepers)
        // decentralized event driven execution
        // end-to-end reliability

        require(getConversionRate(msg.value) >= minUsd,"Send at least 5 USD ");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;

    }
    function getPrice() public view returns(uint256){
        // to call a contract we need Address and an ABI
        // 0x694AA1769357215DE4FAC081bf1f309aDC325306 (address of contract on sepolia)
        int256 price;
        (,price,,,) = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).latestRoundData();
        // 193200000000 
        return uint256(price * 1e10);
    }
    function getConversionRate(uint256 ethAmount) public view returns(uint256){
      uint256 ethePrice = getPrice();
      uint256 ethAmountInUsd = (ethePrice * ethAmount)/1e18;
      return ethAmountInUsd;
    }
}
