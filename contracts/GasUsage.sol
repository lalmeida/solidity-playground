//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract GasUsageExamples {
    
    function testPublicCalldata(uint[10] calldata array) public returns (uint) {
        return array[0];
    } 

    // 	Pure: execution cost 23036 gas (Cost only applies when called by a contract)
    function testExternalCalldata(uint[10] calldata array) external returns (uint) {
        return array[0];
    } 

    // 
    function testPublicMemory(uint[10] memory array) public returns (uint) {
        return array[0];
    } 

    // Pure:  execution cost	25731 gas (Cost only applies when called by a contract)

    /** 
    gas	29591 gas
        transaction cost	25731 gas 
        execution cost	25731 gas
    */ 
    function testExternalMemory(uint[10] memory array) external returns (uint) {
        return array[0];
    } 

}