pragma solidity ^0.4.24;

contract LogicContract{
    uint public a;
    
    function set(uint val)public{
        a = val;
    }
}
contract ProxyContract{
    address public contract_pointer;
    uint public a;
    
    constructor () public{
        contract_pointer = address (new LogicContract());
    }
    
    function set (uint val) public{
        contract_pointer.delegatecall(bytes4(keccak256("set(uint256)")),val);
    }
}