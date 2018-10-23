pragma solidity ^0.4.0;

contract StateModifiers{
    uint private constant varConstantValue = 55;
    uint private stateValue;
    
    function stateAccess() public returns (uint){
        statevalue = 10;
        return stateValue;
    }
    // use constant in contract
    function constantAccess() public constant returns (uint){
        return block.number;
    }
    // use view in contract
    function viewAccess() public view returns (uint){
        return stateValue;
    }
    // use pure in contract
    function pureAccess() public pure returns (uint){
        return varConstantValue;
    }
}