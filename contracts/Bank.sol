//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

/**
 * This Smart Contract behaves as a bank.
 * Users can deposit and withdraw money from their accounts.
 * They can also see their current balances.
 */
contract Bank {

    mapping(address => UserAccount) accounts;

    struct UserAccount {
        address userAddress;
        uint balance;
    }

    event balanceUpdated (address userAddress, uint balance);

    /** 
     * User deposits money in their account.
     */
    function deposit () public payable {
        accounts[msg.sender].balance += msg.value;
        emit balanceUpdated(msg.sender, accounts[msg.sender].balance);
    }

    /** 
     * User withdraws money from their account.
     */
    function withdraw (uint amount) public {
        require (accounts[msg.sender].balance >= amount);
        accounts[msg.sender].balance -= amount;
        emit balanceUpdated(msg.sender, accounts[msg.sender].balance);
    }

    /** 
     * User requests its Balance.
     */
    function getBalance(address userAddress) public view returns (uint) {
        return accounts[userAddress].balance;
    }

}