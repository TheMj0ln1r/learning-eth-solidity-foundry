// SPDX-License-Identifier: MIT

//inheritance
pragma solidity ^ 0.8.18;

import {SimpleStorage} from "./SimpleStorage_Lesson3.sol";

contract AddFiveStorage is SimpleStorage{
    function sayHello() public pure returns(string memory){
        return "Hello";
    }
    // SimpleStorage public simple;
    // SimpleStorage public simple = new SimpleStorage(); // deploying SimpleStorage contract

    //overrides
    //virtual overrides

    function store(uint _favoriteNumber) override public {
        myFavoriteNumber = _favoriteNumber+5;
    }

}

