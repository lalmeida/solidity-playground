//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Arrays {

    uint[][3] fixedSizeArray;

    uint[3][] dynamicSizeArray;
    
    function testFixed() public returns (uint, uint, uint) {

        fixedSizeArray[0].push();
        //fixedSizeArray[2].pop();

        return (fixedSizeArray[0].length , fixedSizeArray[1].length, fixedSizeArray[2].length);
    }

   function getDynaLenght() public returns (uint) {
    
        return (dynamicSizeArray.length);
    }


    function pushDyna() public returns (uint) {

        dynamicSizeArray.push();
    
        return (dynamicSizeArray.length);
    }



}