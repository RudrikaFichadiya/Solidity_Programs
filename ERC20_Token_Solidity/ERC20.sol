pragma solidity ^0.4.0;
interface ERC20 {
    function totalSupply() external constant returns (uint _totalSupply);
    function balanceOf(address _owner) external constant returns (uint balance);
    function transfer(address _to, uint _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint _value) external returns (bool success);
    function approve(address _spender, uint _value) external returns (bool success);
    function allowance(address _owner, address _spender) external constant returns (uint remaining);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

}