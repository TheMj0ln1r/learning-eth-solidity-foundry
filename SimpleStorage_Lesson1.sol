// SPDX-License-Identifier: MIT
pragma solidity 0.8.18; //solidity version 

contract SimpleStorage{
    //Basic types : Boolean, uint, int, address, bytes
    bool booleanType = true; // default is false
    int256 number = -100;
    string name = "mj0ln1r";
    address myAddress = 0x699BceEbD59a5b52bB586C737cD7ba636f3Fe602;
    bytes32 bytesType = "hello"; // bytes1/byte,bytes2,bytes3,4,5,..32
    uint256 unumber; // default is 0
    
    function store(uint256 _unumber) public{
        unumber = _unumber;
    }
}
