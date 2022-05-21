//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

/**
 * This Smart Contract behaves as a bank.
 * Users can deposit and withdraw money from their accounts.
 * They can also see their current balances.
 */
contract Bank {

    mapping(address => UserAccount) accounts;

    address payable owner;

    struct UserAccount {
        address userAddress;
        uint balance;
    }

    event balanceUpdated (address userAddress, uint balance);

    constructor () {
        owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require (msg.sender == owner, "User does not have permission for this operation.");
        _;
    }

    /**
     * Destroy this contract, sending any remaining funds to the owner.
     */
    function destroy() public onlyOwner {
        selfdestruct(owner);
    }

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
        require (amount > 0, "Cannot withdraw a zero amount.");
        require (accounts[msg.sender].balance >= amount, "User does not have enough balance");
        accounts[msg.sender].balance -= amount;
        payable(msg.sender).transfer(amount);
        emit balanceUpdated(msg.sender, accounts[msg.sender].balance);
    }

     /** 
     * User requests its own Balance.
     */
    function getBalance() public view returns (uint) {
        return getBalanceOf(msg.sender);
    }


    /** 
     * Requests Balance of any account.
     * (Should be restricted in production or made private)
     */
    function getBalanceOf(address userAddress) public view returns (uint) {
        return accounts[userAddress].balance;
    }

}