pragma solidity ^0.4.0;

interface Regulator {
    function checkValue(uint amount) returns (bool);
    function loan() returns (bool);
}

contract Bank is Regulator {
    uint private value;
    address private owner;
    
    modifier ownerFunc { //custom modifier ownerFunc
        require(owner == msg.sender); // msg.sender is the address currently interacting with the contract
        _;
    }

    function Bank(uint amount) {
        value = amount;
        owner = msg.sender;
    }
    
    function deposit(uint amount) ownerFunc {
        value += amount;
    }
    
    function withdraw(uint amount) ownerFunc {
        if (checkValue(amount)) {
            value -= amount;
        }
    }
    
    function balance() returns (uint) {
        return value;
    }
    
    function checkValue(uint amount) returns (bool) {
        
        return value >= amount;
    }
    
    function loan() returns (bool) {
        return value > 0;
    }
}

contract MyFirstContract is Bank(10) {
    string private name;
    uint private age;
    
    function setName(string newName) {
        name = newName;
    }
    
    function getName() returns (string) {
        return name;
    }
    
    function setAge(uint newAge) {
        age = newAge;
    }
    
    function getAge() returns (uint) {
        return age;
    }
}

contract TestThrows {
    function testAssert() {
        assert(1 == 2); /* use assert() in error handling for, 
                            Check for underflow and overflow,
                            Validate states after changes,
                            Prevent conditions which should never, ever be posible. */
    }
    
    function testRequire() {  
        require(2 == 1);     /* require(), 
                                validates user inputs
                            */
    }
    
    function testRevert() {
        revert(); /* revert() is used to handle same type of situations,
                    as require() but with more complex logic.*/
    }
    
    function testThrow() {
        throw; /* throw used as an alternative to revert(),but only without error message.*/
    }
}
