pragma solidity ^0.4.0;

contract learnSolidity{
    
	string public nameStud; /* Defining string variable, with public visibility
	                           to store string value inside variable*/
	                           
	uint public age; /* Defining unsigned integer variable/ uint variable with 
	                public visibility*/ 
	
	function learnSolidity ()public { /* this is the constructor of the contract learnSolidity, 
	                                    here we will initialize both the veriable name of Student and Age
	                                    with some static values.*/
	                                    
	       nameStud = 'RHF';
	       age = 20;
	}
}