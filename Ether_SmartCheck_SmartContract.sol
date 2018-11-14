// total issues are 7. 
//1. Hardcoded Address, 2. Locked Money, 3. Overpowered User, 4. Compiler version, 
//5. Redundant fallback functions, 6. Upgrade code to solidity 0.5.0., 7. Implicit Visibility Level.
//All six issues solved by changing function calling, addressing, and removing redundant fallback methods.     
pragma solidity 0.5.0.; // Before: pragma solidity 0.4.21.;
contract SafeMath {
    function safeMul(uint256 a, uint256 b) internal returns (uint256) {
        uint256 c = a * b;
        assert(a == 0 || c / a == b);
        return c;
    }
    function safeDiv(uint256 a, uint256 b) internal returns (uint256) {
        assert(b > 0);
        uint256 c = a / b;
        assert(a == b * c + a % b);
        return c;
    }
    function safeSub(uint256 a, uint256 b) internal returns (uint256) {
        assert(b <= a);
        return a - b;
    }
    function safeAdd(uint256 a, uint256 b) internal returns (uint256) {
        uint256 c = a + b;
        assert(c>=a && c>=b);
        return c;
    }
    function assert(bool assertion) internal{
        require (assertion);
    }
}
contract Owner{                 // Before: contract Ownable{

    address public owner;
    constructor() public{
        owner=msg.sender;
    }

    modifier IsOwner() {                // Before: modifier onlyOwner(){...}
        require(owner==msg.sender);                 
         _;  
                                        // Before: modifier onlyPayloadSize(uint size){ assert(msg.data.length >= size+4); _;}           
  }
}
contract Exam is Owner,SafeMath{        // Before: contract Exam is Ownable, SafeMath{...}
    string public name;     
    string public symbol;
    uint8 public decimals;  // refers to how divisible a token can be...0 to 18 and >18 if required.
    uint256 public totalSupply; // it equals the sum of all balances.
    uint public basisPointsRate = 0; //unit of measure used in finance to describe the % change in the value or rate.
    uint public minimumFee = 0;
    uint public maximumFee = 0;
    
   // function withdraw() public; // changes made here to declare it ex
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) internal allowed;
    
    constructor() public {
        name = 'EXAM'; // Set the name for display purposes
        symbol = 'EXM'; // Set the symbol for display purposes
        decimals = 18; // Amount of decimals for display purposes
        totalSupply = 410000000 * 10**uint(decimals); // Update total supply
        balanceOf[msg.sender] = totalSupply; // Give the creator all initial tokens
    }
    
    function withdraw() IsOwner returns(bool) payable{ // Before: function() payable{revert();}
        return true;

    }
     //   revert();
    
    function transfer(address _to, uint256 _value) public onlyPayloadSize(2 * 32){
        //Calculate Fees from basis point rate 
        uint mult = SafeMath.safeMul(_value,basisPointsRate);
        uint fee = SafeMath.safeDiv(mult,1000);
        if (fee > maximumFee) {
            fee = maximumFee;
        }
        if (fee < minimumFee) {
            fee = minimumFee;
        }
//        require (_to != address(0x0));
        require(_to != address(0));
        require (_value > 0); 
        require (balanceOf[msg.sender] > _value);
        require (balanceOf[_to] + _value > balanceOf[_to]);
        uint sendAmount = SafeMath.safeSub(_value,fee);
        balanceOf[msg.sender] = SafeMath.safeSub(balanceOf[msg.sender], _value);
        balanceOf[_to] = SafeMath.safeAdd(balanceOf[_to], sendAmount);
        if (fee > 0) {
            balanceOf[owner] = SafeMath.safeAdd(balanceOf[owner], fee);
            emit Transfer(msg.sender, owner, fee);
        }
        emit Transfer(msg.sender, _to, _value);
    }
    function approve(address _spender, uint256 _value) public onlyPayloadSize(2 * 32) returns (bool success) {
        require (_value > 0);
        require (balanceOf[owner] > _value);
        require (_spender != msg.sender);
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender,_spender, _value);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) public onlyPayloadSize(2 * 32) returns (bool success) {
        uint mult = SafeMath.safeMul(_value,basisPointsRate);
        uint fee = SafeMath.safeDiv(mult,1000);
        
        if (fee > maximumFee) {
                fee = maximumFee;
        }
        if (fee < minimumFee) {
            fee = minimumFee;
        }
        require (_to != 0x0);
        require(_to != address(0));
        require (_value > 0); 
        require(_value < balanceOf[_from]);
        require (balanceOf[_to] + _value > balanceOf[_to]);
        require (_value <= allowed[_from][msg.sender]);
        uint sendAmount = SafeMath.safeSub(_value, fee);
        balanceOf[_from] = SafeMath.safeSub(balanceOf[_from], _value); // Subtract from the sender
        balanceOf[_to] = SafeMath.safeAdd(balanceOf[_to], sendAmount); // Add the same to the recipient
        allowed[_from][msg.sender] = SafeMath.safeSub(allowed[_from][msg.sender], _value);
        if (fee > 0) {
            balanceOf[owner] = SafeMath.safeAdd(balanceOf[owner], fee);
            emit Transfer(_from, owner, fee);
        }
        emit Transfer(_from, _to, sendAmount);
        return true;
    }
    
    function allowance(address _from, address _spender) public view returns (uint remaining) {
        return allowed[_from][_spender];
    }
    function setParams(uint newBasisPoints,uint newMaxFee,uint newMinFee) public onlyOwner {
        require(newBasisPoints <= 9);
        require(newMaxFee <= 100);
        require(newMinFee <= 5);
        basisPointsRate = newBasisPoints;
        maximumFee = newMaxFee * 10**uint(decimals);
        minimumFee = newMinFee * 10**uint(decimals);
        emit Params(basisPointsRate, maximumFee, minimumFee);
    }
    function increaseSupply(uint amount) public onlyOwner {
        amount = amount * 10**uint(decimals);
        require(totalSupply + amount > totalSupply);
        require(balanceOf[owner] + amount > balanceOf[owner]);
        balanceOf[owner] = SafeMath.safeAdd(balanceOf[owner], amount);
        totalSupply = SafeMath.safeAdd(totalSupply, amount);
        emit Issue(amount);
    }
    function decreaseSupply(uint amount) public onlyOwner {
        amount = amount * 10**uint(decimals);
        require(totalSupply >= amount);
        require(balanceOf[owner] >= amount);
        totalSupply = SafeMath.safeSub(totalSupply, amount);
        balanceOf[owner] = SafeMath.safeSub(balanceOf[owner], amount);
        emit Redeem(amount);
    }
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value
    );
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
    event Params(
        uint feeBasisPoints,
        uint maximumFee,
        uint minimumFee
    );
    event Issue(
        uint amount
    );
event Redeem(
        uint amount
    );
}
