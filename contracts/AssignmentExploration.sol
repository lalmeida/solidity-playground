//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;


/** 
 * Experiments to get my head around data location and assignments.
 * 
 * 
 * From the documentation:
 * "Assignments between storage and memory (or from calldata) always create an independent copy.
 *
 * Assignments from memory to memory only create references. 
 * This means that changes to one memory variable are also visible
 * in all other memory variables that refer to the same data.
 * 
 * Assignments from storage to a local storage variable also only assign a reference.
 * 
 * All other assignments to storage always copy. Examples for this case are assignments 
 * to state variables or to members of local variables of storage struct type, 
 * even if the local variable itself is just a reference."
 */
contract DataLocationAndAssignments {

    struct TestStruct {
        uint number;
        uint[] myArray;
        mapping (uint => uint) myMap;
    }

    struct TestStructNoMapping {
        uint number;
        uint[] myArray;
    }

    TestStruct storageTS;

    TestStructNoMapping storageTSNoMapping;


    uint[] storageArray;

    // array literals (memory) to Storage: Ok!
    uint8[] storageFixedArray = [ 1 , 2, 3 ];
    
    mapping (uint => uint) mapStorage;

  
    function testStorageArraySize() public view returns (uint, uint, uint) {
        return (storageArray.length, storageTS.myArray.length, storageTS.myMap[1]);
    }

   function testMappingAndStruct () internal view returns 
    (TestStructNoMapping memory ts, TestStruct storage  ts2, mapping (uint => uint) storage mp, TestStructNoMapping memory ) {
        
        // Mappings in memory: Not Ok. Need to be in storage
        // mapping (uint => uint) memory mapMemory = mapStorage;
        
        // Struts can be declared in memory
        uint[] memory array = new uint[](0);
        TestStructNoMapping memory memoryTS = TestStructNoMapping ( 1 , array );


        //uint[] memory array2 = [ uint(1),2];  // static array => dynamic array does not work
        uint[] memory array2 = new uint[](2);
        array2[0] = 1;
        array2[1] = 2;
        TestStructNoMapping memory memoryTS2 = TestStructNoMapping ( 1 , array2 );

        
        // mapping & struts can be declared in local storage (being assigned from storage)
        mapping (uint => uint) storage mapLocalStorage = mapStorage;
        TestStruct storage localStorageTS = storageTS;
              

        //  Mappings cannot be created dynamically  
        //  mapping (uint => uint ) storage mapLocalStorage2;
     
        //  Structs cannot be assigned from memory to local storage 
        // TestStruct storage storageTS2 = TestStruct ( 2 );
     

        return (memoryTS, localStorageTS, mapLocalStorage, memoryTS2);

    }


  /** 
    * Dynamic Arrays Assignemnts Summary:
    * 
    *   Memory <=> Memory (OK - )
    *   Storage <=> Storage (OK - )
    *   Memory <=> Storage (OK - Data is copied)
    *   Local Storage <= Storage (OK, reference is used ) 
    *   Storage <= Local Storage  (Not OK)
    *  
    */ 
    function testDynamicArrays(uint[] memory memoryArray) public 
        returns (uint[][5] memory) {

        // Memory from Memory: Ok. Copy by reference
        uint[] memory MfM = memoryArray;
        MfM[1] = 11;
        delete MfM;
        
       // Local Storage from Storage: Ok. Copy by reference.
       uint[] storage LSfS  = storageArray;
       LSfS[1]= 22;
       // delete cannot be applied to type uint256[] [local] storage pointer 
       // delete LSfS; 


        // Storage from Memory: Ok! Copy by value!
        storageArray = memoryArray;
        storageArray[1] = 33;
        delete storageArray;

        // Memory from Storage: Ok! Copy by value!
        uint[] memory MfS  = storageArray;
        //MfS.push(44);

       // Local Storage from Memory: Not Ok. Does not work
       // uint[] storage LSfM  = memoryArray;
       // uint[] storage LSfM;
       // LSfM[1]= 55;
      
        return  [memoryArray, MfM, LSfS, storageArray , MfS ] ;

    } 

    function test() public pure returns (uint[3] memory, uint[] memory) {
        uint[3] memory testArray;
        testArray[0] = 3;
        testArray[1] = 4;
        testArray[2] = 5;
        // pop not available in fixed size arrays
        // testArray.pop();

        uint[] memory testArray2 = new uint[](3);
        testArray2[0] = 13;
        testArray2[1] = 14;
        testArray2[2] = 15;
        
        // pop not available outside of storage
        // testArray2.pop();

        
        return (testArray, testArray2);
    }


    /** 
    * Array Literals Assignemnts Summary:
    * 
    *   Memory <= Array Literals (OK)
    *   Storage <= Array Literals (OK) 
    *   Local Storage <= Array Literals (NOT OK)
    *  
    */ 
  function testArrayLiterals() public returns (uint8[5] memory, uint8[] memory) {

        // cannot assign static array to dynamic array        
        // uint8[] memory memArray = [ 1 , 2, 3 ];

        // array literals to local memory: Ok!
        uint8[5] memory memoryFixedArray = [ 1 , 2, 3, 4, 5 ];
        
        // array literals to local storage: Not Ok!
        // uint8[3] storage localStorageFixedArray = [ 1 , 2, 3 ];

        // Storage from Array Literals: Ok! 
        storageArray = [ 1 , 2 , 3 ];

        // Storage from Memory: Ok! Data is copied!
        storageArray = memoryFixedArray;
        storageArray[1] = 22;
        delete storageArray;

        // Memory from Storage: Not Ok!
        // uint8[3] memory MfS  = storageFixedArray;
        
       // Local Storage from Memory: Not Ok. Does not work
       // uint8[5] storage LSfM  = memoryFixedArray;
       // LSfM[1]= 44;


       // Local Storage from Storage: Ok. Data is not copied.
       uint8[] storage LSfS  = storageFixedArray;
       LSfS[1]= 55;
       // delete cannot be applied to type uint8[] [local] storage pointer
       // delete LSfS; 

        return  (memoryFixedArray, LSfS) ; // , storageArray , LSfS] ;

    } 

    /** 
    * It is not possible to convert from Memory to Local Storage.
    */ 
    function testLocalStorageFromMemory() public view {
        
        // cannot convert from memory to local storage    
        // TestStructNoMapping storage localStorageTSNoMapping = TestStructNoMapping(1, new uint[](0));

        // cannot convert from memory to local storage    
        // uint[] storage localStorageArray = new uint[](0);

        // cannot instantiate memory Mappings.
        // "Mappings can only have a data location of storage and thus are allowed for
        //  state variables, as storage reference types in functions, or 
        //  as parameters for library functions"
        // mapping (uint => uint) storage localMapStorage = mapping (uint => uint);

    }


}