pragma solidity ^0.5.0 ;
 
contract Test {
  // float addresult;
   int a;
   int b;
   int c;
   function set_add_data(int A, int B) public{
       a =A;
       b =B;
   //    result = addresult;
       c = a+b;
   }
   function get_add_data() public returns(int){
       return (c) ;
   }
}