pragma solidity ^0.4.0;

interface token{
    function transfer (address receiver, uint amount) external;
}

contract SaleCrowd{
    
    address public beneficiary;
    uint public fundingGoal;
    uint public amountRaised;
    uint public deadline;
    uint public price;
    token public tokenReward;
    
    mapping (address => uint256) public balanceOf;
    bool fundingGoalReached = false;
    bool crowdsaleClosed = false;
    
    event GoalReached(address recipient, uint totalAmountRaised);
    event FundTransfer(address backer, uint amount, bool isContribution);

    function Crowdsale(
        address ifSuccessfulSendTo, 
        uint fundingGoalInEthers,
        uint durationInMinutes, 
        uint etherCostOfEachToken, 
        address addressOfTokenUsedAsReward
    ) public{
        beneficiary = ifSuccessfulSendTo;
        fundingGoal = fundingGoalInEthers * 1 ether; 
        deadline = now + durationInMinutes * 1 minutes;
        price = etherCostOfEachToken * 1 ether;
        tokenReward = token(addressOfTokenUsedAsReward);  
    }
    
    function () payable {
        require(!crowdsaleClosed);
        uint amount = msg.value;
        balanceOf[msg.sender] += amount;
        amountRaised += amount;
        tokenReward.transfer(msg.sender, amount / price);
        emit FundTransfer(msg.sender, amount, true);
    }
    
    modifier afterDeadline() { if (now >= deadline) _; }
    
    function checkGoalReached() public afterDeadline{
        if (amountRaised >= fundingGoal){
            fundingGoalReached = true;
            emit GoalReached(beneficiary, amountRaised);
        }
        crowdsaleClosed = true;
    }
    
    function safeWithdrawal() public afterDeadline {
        
        if(!fundingGoalReached){
            uint amount = balanceOf[msg.sender];
            balanceOf[msg.sender] = 0;
            
            if (amount > 0){ // amount shoud be more than 0
                if (msg.sender.send(amount)){ // send the amount using address of sender
                    emit FundTransfer(msg.sender, amount, false);
                } else {
                    balanceOf[msg.sender] = amount;
                }
            }
        }
        if (fundingGoalReached && beneficiary == msg.sender){
            if (beneficiary.send(amountRaised)){
                emit FundTransfer(beneficiary, amountRaised, false);
            } else {
                // if we fail to send the funds to beneficiary, unlock funder balance
                fundingGoalReached = false;
            }
        }
    }
}