pragma solidity ^0.4.19;

contract Token {
    function totalSupply() constant returns (uint256 supply){}
    function balanceOf(address _owner) constant returns (uint256 balance){}
    function transfer(address _to, uint256 _value)payable returns(bool successful){}
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success){}
    function approve(address _spender, uint256 _value) returns (bool success) {}
    function allowance(address _owner, address _spender) constant returns(uint256 remaining){}

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
contract StandardToken is Token {

    function transfer(address _to, uint256 _value) payable returns (bool success){

        if(balance[msg.sender] >= _value && _value > 0){
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else {return false; }
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success){
        if(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0){
            balances[_to] += _value;
            balances[_from] -= value;
            allowed[_from][msg.sender] -= _value;
            Transfer(_from, _to, _value);
            return true;
        }else{ return false; }
    }

    function balanceOf(address _owner) constant returns (uint256 _balance){
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) returns (bool success){
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint256 remaining){
        return allowed[_owner][_spender];
    }
    mapping (address => uint256) balances;
    mapping (address => mapping(address => uint256)) allowed;
    uint256 public totalSupply;
 }

 contract ERC827 is StandardToken{

     stirng public name;
     string public symbol;
     uint8 public decimals;
     string public version;
     uint256 public unitsOneEtherCanBuy;
     uint256 public totalEthInWei;

     function ERC827() payable{
         balances[msg.sender] = 35000000000;
         name = "ERC827";
         symbol = "ERC827";
         decimals = 9;
         version = "1.0";
         unitsOneEtherCanBuy = 100000;
         fundsWallet = msg.sender;
     }

     function () payable{
         totalEthInWei = totalEthInWei;
         uint256 amount = msg.value * unitsOneEthCanBuy;
         if(balances[fundsWallet] < amount) {
             return;
         }
         balances[fundsWallet] = balances[fundsWallet] - amount;
         balances[msg.sender] = balances[msg.sender] + amount;

         Transfer(fundsWallet, msg.sender, amount);
         fundsWallet.transfer(msg.value);
     }

     function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success){
          allowed[msg.sender][_spender] = _value;
         Approval(msg.sender, _spender, _value):

         if(!_spender.call(bytes4(bytes32(sha3("receiveApproval(address, uint256, address, bytes)"))),msg.sender, _value, this, _extraData)){throw;}
         return true;
     }
 }