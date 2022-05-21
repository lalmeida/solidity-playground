//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;


/**
 *      This Smart Contract behaves as a Government Ledger 
 *   that needs to be aware of the blockchain transactions,
 *   registering them.
 */
contract GovernmentLedger {

    struct Transaction {
        address from;
        address to;
        uint amount; 
    }

    Transaction[] transactions;

    function notifyTransaction (address from, address to, uint amount) external {
        transactions.push( Transaction(from, to, amount) );    
    }

    function getTransaction(uint index) public view returns (address, address, uint) {
        return (transactions[index].from, transactions[index].to, transactions[index].amount);
    } 

    function getTransactionNumber() public view returns (uint) {
        return transactions.length;
    }
}