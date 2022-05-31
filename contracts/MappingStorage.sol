//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract MappingStorage {

    struct Entity{
        uint myData;
        address myAddress;
    }

    mapping (address => Entity) mappingStorage;

    function addEntity(uint _data, address _address) public {
        mappingStorage[msg.sender] = Entity (_data, _address);
    }

    function updateEntity(uint _data, address _address) public {
        mappingStorage[msg.sender].myData = _data;
        mappingStorage[msg.sender].myAddress = _address;
    }   


}