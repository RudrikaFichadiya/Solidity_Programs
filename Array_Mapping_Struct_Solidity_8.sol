pragma solidity ^0.4.0;

contract DataTypes{
    
    bool myBool = false; // boolean datatypes
    
    int8 myInt = -128; // signed integer
    uint8 myUint = 255; // unsigned integer
    
    string myString; // string type variable declaration
    uint8[] myStringArr; // array 
    
    byte myValue;
    bytes1 myBytes1;
    bytes32 myBytes32;
    
    enum Action {ADD, REMOVE, UPDATE} //enum datatypes
    Action myAction = Action.ADD;
    
    address myAddress; // address type to store the address of sender and receiver
    function assignAddress(){
        myAddress = msg.sender; // will store the address of the sender in variable myAddress
        myAddress.balance; // will retrive balance of myAddress
        myAddress.transfer(10);
        
    }
    
    uint[] myIntArr = [1,2,3]; // creating integer array named myIntArr with three different values, 1,2,3.
    
    function arrFunc() {
        myIntArr.push(1);
        myIntArr.length;
        myIntArr[0];
    }
    
    uint[10] myFixedArr; // fixed length array declaration of size 10

    /*Defining structure type using keyword struct
      with name Account.
      Account having two member variables, 
      balance type of unsigned integer, and dailylimit also a type of unsigned integer*/
    sturct Account {
        uint balance;
        uint dailylimit;
    }
    
    Account myAccount; // create myAccount to use struct type 
    function structFunc() {
        myAccount.balance = 100; // assigning values to balance = 100 using structure variable
    }
    
    
    mapping (address => Account)_accounts;
    
    function mappingFunc() payable{
        _accounts[msg.sender].balance += msg.value;
    }
    
    function getBalance() returns (uint){
        return _accounts[msg.sender].balance;
        
    }
}
