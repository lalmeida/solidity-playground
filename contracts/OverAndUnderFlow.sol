//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;


/**
 * Testing Solidity handling of underflow and overflow.
 */
contract OverAndUnderflow {

    uint8 n = 0;

    function increment() external {
        n++;
    } 

    function decrement() external {
        n--;
    }

    function getN() external view returns (uint8) {
        return n;
    } 


}