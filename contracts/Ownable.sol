//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

abstract contract Ownable {
 
    address payable owner;

    constructor () {
        owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require (msg.sender == owner, "User does not have permission for this operation.");
        _;
    }

}