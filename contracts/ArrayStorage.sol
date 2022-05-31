//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

/**
 * Experimenting with gas costs 
 */
contract ArrayStorage {

   struct Entity {
        uint myData;
        address myAddress;
    }

    Entity[] arrayStorage;

    function addEntity(uint myData) public {
        arrayStorage.push( Entity(myData, msg.sender) );
    }

    function updateEntity(uint myData) public {
        
        for (uint i=0 ; i < arrayStorage.length ; i++) {
            if (arrayStorage[i].myAddress == msg.sender ) {
                arrayStorage[i].myData = myData;
            }
        }

    }  

}