pragma solidity ^0.4.25;

library SafeMathLib {

     function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(a >= b, "the result of the subtraction is negative");
        return(a - b);
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c>=a && c>=b);
        return c;
    }
}
contract Owned {
    address public owner;
    // address public newOwner;

    // event OwnershipTransferred(address indexed from, address indexed to);

    constructor() public {
        owner = msg.sender;
    }

    modifier IsOwner {
        require(owner == msg.sender);
        _;
    }
}
contract MyToken is Owned{
     using SafeMathLib for uint256; 
    
    string public name;
    uint public decimal;
    string public symbol;
    uint public finalsupply;
    
    mapping (address => uint) public finaladdressof;
    mapping (address => mapping(address => uint)) public finalallowance;
    
    event Transfer(address indexed from, address indexed to, uint _value);
    event Approval(address indexed owner, address indexed spender, uint _value);
    
    constructor() public{
        name = "My First Token";
        decimal = 18;
        symbol = "Token";
        finalsupply = 1000000000000000000;
        finaladdressof[msg.sender]=finalsupply;
    }
    
     function totalSupply()public view returns (uint theTotalSupply){
         theTotalSupply = finalsupply;
         return theTotalSupply;
     }
    
    function balanceOf(address _owner)public view returns (uint balance){
        return finaladdressof[_owner];
    }
    
    function transfer(address _to, uint _value)private returns (bool success){
        if(_value>0 && _value<=balanceOf(msg.sender)){
         finaladdressof[msg.sender] -= _value;
         finaladdressof[_to] += _value;
         return true;
        }
        return false;
    }
 
      
    function transferFrom(address _from, address _to, uint _value)private returns (bool success){
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
        finalallowance[msg.sender][_spender] = _value;
        return true;
     }
 
   function allowance(address _owner, address _spender)public view returns (uint remaining){
       return finalallowance[_owner][_spender];
   }
}