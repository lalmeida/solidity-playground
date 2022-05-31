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

    /**
     * execution cost	88190/71102/71114/71090  gas 
     */
    function addEntity(uint myData) public {
        arrayStorage.push( Entity(myData, msg.sender) );
    }

     /**
     * execution cost   52489 /  55289 / 55289 gas
     */
    function updateEntity(uint myData) public {
        
        for (uint i=0 ; i < arrayStorage.length ; i++) {
            if (arrayStorage[i].myAddress == msg.sender ) {
                arrayStorage[i].myData = myData;
            }
        }

    }  

     /**
     * execution cost (w/ require)  31523 / 31511 / 31535  gas
     * (w/o require): 26344  / 29156 / 29156 gas
     */
    function updateEntity(uint index, uint myData) public {
        //require (arrayStorage[index].myAddress == msg.sender, "Caller cannot update this index.");
        arrayStorage[index].myData = myData;
    }  


}