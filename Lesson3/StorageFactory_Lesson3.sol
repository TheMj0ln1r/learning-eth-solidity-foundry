// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

// we can copy the enire SimpleStorage contract here and
// can use this to deploy the SimpleStorage from StorageFactory
// or we can just import the file
//import "./SimpleStorage_Lesson3.sol";// importing all
import {SimpleStorage} from "./SimpleStorage_Lesson3.sol";// importing only one 



contract StorageFactory{
    SimpleStorage public simpleStorage;
    function createSimpleStorageContract() public {
        simpleStorage = new SimpleStorage();
        // new keyword can deploy contracts from other contracts
    }
    function get() view public returns(uint256){
        uint256 a = simpleStorage.retrieve();
        return a;
    }

    // array of SimpleStorage contracts
    SimpleStorage[] public listOfsimpleStorage;
    function newSimpleStorageContract() public {
        //listOfsimpleStorage.push(new SimpleStorage());
        SimpleStorage newSimpleStorage = new SimpleStorage();
        listOfsimpleStorage.push(newSimpleStorage);
    }

    //interacting with SimpleStorage contract
    function sfStore(uint256 _simpleStorageIndex, uint256 _numberToStore) public{
        //Address
        //ABI 
        SimpleStorage mySimpleStorage = listOfsimpleStorage[_simpleStorageIndex];
        mySimpleStorage.store(_numberToStore);
    }
    function sfGet(uint256 _simpleStorageIndex) view public returns(uint256){
        return listOfsimpleStorage[_simpleStorageIndex].retrieve();
    }
    
}

