pragma solidity ^0.4.24;
//A typical use-case of the delegatecall opcode is to implement libraries.

library LibR{
    struct Data { uint val;}

    function set(Data storage self, uint new_val) public{
        self.val = new_val;
    }
}

contract C{
    LibR.Data public my_val;
    
    function set(uint new_val)public{
        LibR.set(my_val,new_val);
    }
}