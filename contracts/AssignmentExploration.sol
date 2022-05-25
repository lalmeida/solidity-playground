//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract AssignmentExploration {

    uint[] storageArray;

   function test(uint[] memory memoryArray) public returns (uint[][4] memory) {

        // Storage from Memory: Ok!
        storageArray = memoryArray;
        storageArray[1] = 22;

        // Memory from Storage: Ok!
        uint[] memory MfS  = storageArray;
        MfS[1]= 33;

       // Local Storage from Memory: Not Ok. Does not work
       // uint[] storage LSfM  = memoryArray;
       // uint[] storage LSfM;
       // LSfM[1]= 44;


       // Local Storage from Storage: Ok
       uint[] storage LSfS  = storageArray;
       LSfS[1]= 55;


        return  [memoryArray, storageArray , MfS, LSfS] ;

    } 


    function testPopPush() private pure returns (uint8[2] memory) {

        return  [ 1, 3] ;

    }


}