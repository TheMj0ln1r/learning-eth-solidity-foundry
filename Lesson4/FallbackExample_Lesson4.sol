// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FallbackExample{
    uint256 public  result;
    // receive function invoked when no data is sent in the transaction
    receive() external payable {
        result = 1;
    }

    // fallback function executed when none of the other finctions are matched with the function call data
    fallback() external payable{
        result += 100;
    }

}

 /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */