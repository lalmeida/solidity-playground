//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

/**
 * Experimenting with gas costs 
 */
contract MappingStorage {

    struct Entity{
        uint myData;
        address myAddress;
    }

    mapping (address => Entity) mappingStorage;

    /**
     * execution cost	66054 / 66090 / 66114 gas
     * further executions for same msg.sender (update): 29066 / 29078 gas (cost similar to update function) 
     */
    function addEntity(uint _data) public {
        mappingStorage[msg.sender] = Entity (_data, msg.sender);
    }

    /**
     * execution cost  26719 / 23931 / 23943 gas
     *  (for new msg.senders)    43831 
     */
    function updateEntity(uint _data) public {
        mappingStorage[msg.sender].myData = _data;
    }   


}