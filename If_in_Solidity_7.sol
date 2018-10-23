pragma solidity ^0.4.0;

contract CurrencyCreator {
    address public creator; // without this public keyword other contracts can not be able to access this field. 
    mapping (address => uint) public balances; // mapping is thought of as hash table of key value pairs.
    
    event Delivered(address from, address to, uint amount);
    // event indicates that some event gonna be happened or triggered.
    // when event gets fired the listeners will listen address from, address to and particular transfered amount.
    //the above given event statement is also very useful and easy to track transaction.
    function CurrencyCreator(){
        creator = msg.sender; // in this constructor we record address of creator
    }
    
    function createCurrency(address receiver, uint amount){
        if(msg.sender != creator) throw; // here only the creator can invoke the create function to issue currency. and check senfer of the msg is same as the creator.
        balances[receiver] += amount; // if the above condition will false then and then currency can be create.
    }
    
    function transferCurrency(address receiver, uint amount){ //
        if (balances[msg.sender] < amount) throw; // here we verify account balance...have amount in your account
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        Delivered(msg.sender, receiver, amount); // it will notify listeners of the successfull transfer
    }
}