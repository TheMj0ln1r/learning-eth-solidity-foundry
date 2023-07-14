// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //solidity version 

contract SimpleStorage{
    //Basic types : Boolean, uint, int, address, bytes
    bool booleanType = true; // default is false
    int256 number = -100;
    string name = "mj0ln1r";
    address myAddress = 0x699BceEbD59a5b52bB586C737cD7ba636f3Fe602;
    bytes32 bytesType = "hello"; // bytes1/byte,bytes2,bytes3,4,5,..32
    uint256 public unumber; // default is 0
    
    function store(uint256 _unumber) public{
        unumber = _unumber;
        //uint256 testvar = 100;
    }

    function something() public{
        unumber = 999; // okay
        //testvar = 99; // error: not defined in this scope
    }


    // view, pure functions dont need to send a transaction to call
    function retrieve() public view returns(uint256){
        //unumber = unumber + 1; // view functions cant change state of bc
        return unumber;
    }
    function nothing(uint256 _x) public pure returns(uint256){
        //unumber = unumber + 1; // view functions cant change state of bc
        //return unumber; // pure functions dont even allow to read data of blockchain
        return _x * 2;
    }
    // view and pure funtions doesnt need to spend gas or any transaction
    // These will be cost some gas only when some other function which 
    // requires gas to call.
    // example : calling retrieve() in store()

    //arrays
    uint256[] listOfNumbers;

    //struct
    struct Person{
        string name;
        uint256 age;
    }
    Person public abc = Person("charan",21);
    Person public def = Person({name:"hello",age: 19});

    //array of structures 
    Person[] public persons; // [] //dynamic array
    //Person[3] public persons; // [] // static

    // function addPerson(string memory _name, uint _age) public{
    //     Person memory newPerson = Person(_name,_age);
    //     persons.push(newPerson);
    //     // persons.push(Person(_name,_age));
    // }

    //errors

    // data store in solidity : stack, memory, storage, calldata,code, logs

    //calldata, memory --> exists for sometime/temoporary
    // memory variable can be modified, but not calldata variable

    //storage variable is perminant
    // a variable created outside the function is storage var in default

    // arrays, structs and mappings are special type they cant be declared are memory
    // uint256[] memory listofnums; // invalid

    //mappings : much easier way to find or search 
    // key -> value pairs

    mapping(string => uint256) public nameToAge;

    function addPerson(string memory _name, uint _age) public{
        Person memory newPerson = Person(_name,_age);
        persons.push(newPerson);
        nameToAge[_name] = _age;
    }

    //EVM
    // any blockchain which is compatibale with EVM
    // we can deploy solidity contract to it
    // EVM compatible blockchains : Ethereum, Polygon, Arbitrum, Optimism, Zksync
}