pragma solidity ^0.4.25;

contract hash{
    
    bytes32 operationHash;
    bytes32 ercOperationHash;
    event Transacted(bytes32 operationhash,uint256 time);

    function operationhash(address toAddress, uint value, bytes data,uint expireTime, uint sequenceId) public{
        require(expireTime > block.timestamp);
        operationHash = keccak256(abi.encodePacked("ETHER", toAddress, value, data, expireTime, sequenceId));
        emit Transacted(operationHash,block.timestamp);
    }//
    
    function ercoperationhash(address toAddress, uint value, address ContractAddress,uint expireTime, uint sequenceId) public{
        require(expireTime > block.timestamp);
        ercOperationHash = keccak256(abi.encodePacked("ERC20", toAddress, value, ContractAddress, expireTime, sequenceId));
        emit Transacted(ercOperationHash,block.timestamp);
    }
}