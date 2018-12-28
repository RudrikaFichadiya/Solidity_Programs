pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2; // special functionality provided to pass Dynamic array also string type []

/* Program for voting for given option */
contract Voter{
    
    struct OptionPos{   // struct used for collection of different data types as user defines
        uint pos;
        bool exists;
    }                           
    
    uint[] public votes; //dynamic array for storing the votes
    string[] public options; // Options in in the form of string value entered by user - dynamic string array
    
    mapping (address => bool) hasVoted; // mapping to check user has voted or not
    mapping (string => OptionPos) posOfOption;    // to map position of options
    
    constructor(string[] _options)public{ // we have to enter our desired options in text field after deploy
    // ex. ["Marvel", "Warner"] in array element form separated with comma and covered with ""
        options = _options;
        votes.length = options.length; // here we will provide two option i.e. 0,1
    
        for(uint i = 0; i < options.length; i++){
            OptionPos memory  optionPos = OptionPos (i, true); //memory will strore temporarily
            string optionName = options[i];
            posOfOption[optionName] = optionPos;
            
        }
    }
    
    function vote(uint option)public{
        require(0 <= option && option < options.length, "Invalid option");
        require(!hasVoted[msg.sender], "Account has already Voted");
    
        votes[option] = votes[option] + 1;
        hasVoted[msg.sender] = true;
        
    }
    
    function vote(string OptionName)public{
        require(!hasVoted[msg.sender],"Account has already Voted");
        OptionPos memory optionPos = posOfOption[OptionName];
        
        require(optionPos.exists,"Option does not exists");
        votes[optionPos.pos] = votes[optionPos.pos] +1 ;
        hasVoted[msg.sender] = true;
    }
    /* The function has view type of visibility so,
     this function cannot change the state of the contract */

    function getOptions() public view returns (string[]){
        return options;
    }
    function getVotes() public view returns (uint[]){
        return votes;
    }
} 
