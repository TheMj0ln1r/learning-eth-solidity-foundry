// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SafeMathTester{
    uint8 public bigNumber = 254;
    uint8 public uncheckedBig = 255;
    function add() public {
        bigNumber = bigNumber + 1;
        // in solidity version ^0.6.0 this will change the bigNumber value 
        // to 0 , this behaviour called as unchecked 
        // in solidity ^0.8.0, The default behaviour is changed to checked
        // checked means it will return error that u are reached upper limit of uint8
        // we can explicitly invoke unchecked behaviour using unchecked {}
        unchecked {uncheckedBig = uncheckedBig + 1;}
                // unchecked can be used to code gas efficient

    }   
}
