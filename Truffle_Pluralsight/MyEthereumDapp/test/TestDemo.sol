pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "../contracts/test.sol";

contract Testdemo {
    function testdata() public {
        test t = new test();
        t.setOption("int a");
        t.setOption("int b");
        t.set_add_data();
    }
}