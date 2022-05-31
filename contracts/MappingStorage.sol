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

    function addEntity(uint _data) public {
        mappingStorage[msg.sender] = Entity (_data, msg.sender);
    }

    function updateEntity(uint _data) public {
        mappingStorage[msg.sender].myData = _data;
    }   


}