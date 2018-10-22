pragma solidity ^0.4.0;

interface Regulator{
    function checkValue(uint amount) returns (bool);
    function loan() returns (bool);
    
}

contract Bank is Regulator{
    uint public value;
    //the above value variable will be initializes with value 10 from MySecondContract contract
    function Bank(uint amount){
    // constructor of the contract Bank
    value = amount; 
        
    }
    function deposit(uint amount){
        value += amount;
    }
    function withdraw(uint amount){
        
        if(checkValue(amount)){
            
            value -= amount;
        }
    }
    
    function balance() returns (uint){
        return value;
    }
    
    function checkValues(uint amount) returns (bool){
        return value >= amount;
    }
    
    function loan() returns (bool){
        return value > 0;
    }
}

contract BankContract is Bank(10){
    string private name;
    uint private age;
    
    function setName(string newName) {
        name =newName;
    }
    
    function getName() returns (string){
        return name;
    }
    
    function setAge(uint newAge){
        age = newAge;
    }
    
    function getAge() returns (uint){
        return age;
    }
 }