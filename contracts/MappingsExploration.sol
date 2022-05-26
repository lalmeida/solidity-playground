//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract MappingsExploration {

    struct Account {
        uint id;
        string accountHolderName;
    }

    mapping (uint => Account ) accounts;

    /** 
    * Memory to Storage: copy-by-value!
    */ 
    function changeName(uint id, string calldata name) public returns (Account memory, Account memory) {
        Account memory acc = Account(id, name); 
        accounts[id] = acc; // Storage <= Memory : copy-by-value
        acc.accountHolderName = "X"; // this does not alter the "accounts" mapping. 
        return (acc, accounts[id]);
    }

    function getAccount(uint id) public view returns (Account memory) {
        return accounts[id]; 
    }


}