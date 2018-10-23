pragma solidity ^0.4.0;

contract Transaction{
    // we will now write two event logging mechanisms
    
    event SenderLogger (address);// first for Logging got the sender's address, event log record
    event ValueLogger (uint);//sent to the transaction/contract

    address private owner;
    
    modifier isOwner{ //here we are creating modifier to compare owner and SenderLogger
        require(owner == msg.sender);
        _;
    }
    
    modifier validValue{
        assert(msg.value >= 1 ether);
        _;
        
    }
    function Transaction(){
        owner = msg.sender;
    }
    
    function () payable isOwner validValue { // simple fallback function
        SenderLogger(msg.sender);
        ValueLogger(msg.value);
        
        //1 ether;
    }
}