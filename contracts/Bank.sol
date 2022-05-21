//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "./Destroyable.sol";


interface GovernmentLedger {
    function notifyTransaction (address from, address to, uint amount) external;    
}

/**
 * This Smart Contract behaves as a Bank.
 * Users can deposit and withdraw money from their accounts.
 * They can also see their current balances.
 */
contract Bank is Destroyable {

    mapping(address => UserAccount) accounts;

    address governmentLedgerAddress;

    struct UserAccount {
        address userAddress;
        uint balance;
    }

    event balanceUpdated (address userAddress, uint balance);

    /**
     * User deposits money in their account.
     */
    function deposit () public payable {
        require (msg.value > 0, "Cannot deposit a zero amount.");
        accounts[msg.sender].balance += msg.value;
        emit balanceUpdated(msg.sender, accounts[msg.sender].balance);
        getGovernmentLedger().notifyTransaction(msg.sender, address(this), msg.value);
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
        getGovernmentLedger().notifyTransaction(address(this), msg.sender, amount);
    }

     /**
     * User requests its own Balance.
     */
    function getBalance() public view returns (uint) {
        return accounts[msg.sender].balance;
    }


    /**
     * Requests Balance of any account.
     * Operation can only be executed by the owner of the contract.
     */
    function getBalanceOf(address userAddress) public onlyOwner view returns (uint) {
        return accounts[userAddress].balance;
    }

    /**
      * Sets the address of the government ledger.
      * Operation can only be executed by the owner of the contract.
      **/
    function setGovernmentLedgerAddress(address govtLedger) public onlyOwner {
        governmentLedgerAddress = govtLedger;
    }
 
    /**
    * Returns the Government Ledger Address.
    * Operation can only be executed by the owner of the contract.
    **/
    function getGovernmentLedgerAddress() public onlyOwner view returns (address) {
        return governmentLedgerAddress;
    }

    function getGovernmentLedger() private view returns (GovernmentLedger) {
        require (governmentLedgerAddress!=address(0),"Government Ledger Address needs to be set.");
        return GovernmentLedger(governmentLedgerAddress);
    }

}