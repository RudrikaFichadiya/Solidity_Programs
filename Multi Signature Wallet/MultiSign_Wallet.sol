pragma solidity ^0.5.1;

contract MultiSigWallet{
    
    uint totalApproval;
    uint minApprovers;
    address payable beneficiary;
    address payable owner;
    
    mapping (address => bool) approvedBy;
    mapping (address => bool) isApprover;
    
    // List of Approvers that can approve or reject transaction 
    constructor(address[] memory _approvers, 
                uint _minApprovers, 
                address payable _beneficiary)public payable{
                    
        require(_minApprovers <= _approvers.length, "Require number of approvers should be less than number of Approvers");
        minApprovers = _minApprovers;
        beneficiary = _beneficiary;
        owner = msg.sender;
        
        for(uint i = 0; i< _approvers.length; i++){
            address approver = _approvers[i];
            isApprover[approver] = true;
        }
    }
    
    function approve() public {
          require(isApprover[msg.sender], "Not an approver");
          if(!approvedBy[msg.sender]){
              totalApproval++;
              approvedBy[msg.sender] = true;
          }
          if (totalApproval == minApprovers){
              beneficiary.transfer(address(this).balance);
              selfdestruct(owner);
          }
    }
    function reject() public {
        require(isApprover[msg.sender], "Not an approver");
        selfdestruct(owner);
    }
}