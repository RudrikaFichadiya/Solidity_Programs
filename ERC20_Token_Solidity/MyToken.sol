pragma solidity ^0.4.0;

import "browser/ERC20.sol";

contract MyToken is ERC20{
    
    string public constant name = "My First Token";
    uint public constant decimal = 18;
    string public constant symbol = "Token";
    
    uint private constant finalsupply = 1000000000000000000;
    mapping (address => uint) private finaladdressof;
    mapping (address => mapping(address => uint)) private finalallowance;
    
    constructor() public{
        finaladdressof[msg.sender]=finalsupply;
    }
    
     function totalSupply()external constant returns (uint theTotalSupply){
         theTotalSupply = finalsupply;
     }
    
    function balanceOf(address _owner)public view returns (uint balance){
        return finaladdressof[_owner];
    }
    
    function transfer(address _to, uint _value)external returns (bool success){
        if(_value>0 && _value<=balanceOf(msg.sender)){
         finaladdressof[msg.sender] -= _value;
         finaladdressof[_to] += _value;
         return true;
        }
        return false;
    }
    
    function transferFrom(address _from, address _to, uint _value)public returns (bool success){
     
       if (
        finalallowance[_from][msg.sender] > 0 &&
        _value > 0 &&
        finalallowance[_from][msg.sender] >= _value 
        && 
        finaladdressof[_from] >= _value
            ) {
            finaladdressof[_from] -= _value;
            finaladdressof[_to] += _value;
        
            // finalallowance[_from][msg.sender] -= _value;
            return true;
         }
         return false;
    }
    
     function approve(address _spender, uint _value)public returns (bool success){
        finalallowance[msg.sender][_spender] =_value;
        return true;
     }
     
   function allowance(address _owner, address _spender)public constant returns (uint remaining){
       return finalallowance[_owner][_spender];
   }
}