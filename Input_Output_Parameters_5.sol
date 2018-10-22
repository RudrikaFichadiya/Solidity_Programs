pragma solidity ^0.4.0;

contract SimpleInputPara {
    uint sum;
    function taker(uint _a, uint _b) public {
        sum = _a + _b;
    }
}

contract SimpleOutputPara {
    function arithmetic(uint _a, uint _b)
        public
        pure
        returns (uint o_sum, uint o_product)
    {
        o_sum = _a + _b;
        o_product = _a * _b;
    }
}