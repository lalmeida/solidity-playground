//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract AssignmentExploration {

    struct TestStruct {
        uint number;
    }

    TestStruct storageTS;

    uint[] storageArray;

    mapping (uint => uint) mapStorage;

   function test(uint[] memory memoryArray) public returns (uint[][4] memory) {

        // Storage from Memory: Ok!
        storageArray = memoryArray;
        storageArray[1] = 22;
        delete storageArray;

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
       //delete LSfS; 

        return  [memoryArray, storageArray , MfS, LSfS] ;

    } 

    function testMapping () internal view returns 
    (TestStruct memory ts, TestStruct storage  ts2, mapping (uint => uint) storage mp ) {
        
        // Mappings in memory: Not Ok. Need to be in storage
        // mapping (uint => uint) memory mapMemory = mapStorage;
        
        // Struts can be decared in memory
        TestStruct memory memoryTS = TestStruct ( 1 );

        // mapping & struts can be declared in local storage (being assigned from storage)
        mapping (uint => uint) storage mapLocalStorage = mapStorage;
        
        //  cannot assign from memory to local storage 
        // TestStruct storage storageTS = TestStruct ( 2 );
        
        //  can assign from storage to local storage 
        TestStruct storage localStorageTS = storageTS;

        return (memoryTS, localStorageTS, mapLocalStorage);

    }


    function testPopPush() private pure returns (uint8[2] memory) {

        return  [ 1, 3] ;

    }


}