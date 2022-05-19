//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

contract Convert {

    function numberFromAscII(bytes1 b) private pure returns (uint8 res) {
        if (b>="0" && b<="9") {
            return uint8(b) - uint8(bytes1("0"));
        } else if (b>="A" && b<="F") {
            return 10 + uint8(b) - uint8(bytes1("A"));
        } else if (b>="a" && b<="f") {
            return 10 + uint8(b) - uint8(bytes1("a"));
        }
        return uint8(b); // or return error ... 
    }

   

    function convertString(string memory str) public pure returns (uint256 value) {
        
        bytes memory b = bytes(str);
        uint256 number = 0;
        for(uint i=0;i<b.length;i++){
            number = number << 4; // or number = number * 16 
            number |= numberFromAscII(b[i]); // or number += numberFromAscII(b[i]);
        }
        return number; 
    }

}