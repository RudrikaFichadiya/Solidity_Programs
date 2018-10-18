pragma solidity ^0.4.0;
 /* code written for solidity version 0.4.0*/

/*here contract is a Keyword in solidity to define a Smart Contract*/

contract SimpleStorage { 
    uint storedData; /* storedData is a variable which stores data, and its type is uint...
     means unsigned integer */

   
    function set(uint x) {
        storedData = x;
        /*here set method is used to set or modify and set value of a variable.*/ 
    }
    function get() constant returns (uint retVal) {
        return storedData;
        /*here get method is used to get or modify value of a variable.*/
    }
}
