pragma solidity ^0.4.1;
import "github.com/oraclize/ethereum-api/oraclizeAPI_0.4.sol";

/*  - Oraclize provides a way to get OUTSIDE DATA from any web API onto BLOCKCHAIN.
    - To use it, we'll use Oraclize's SMART CONTRACT to SEND a QUERY to Oraclize, with our API call.
    - Once they get the RESULT from API, they call function named _CALLBACK in our smart contract and pass it the result as an input.
*/
contract WolframAlpha is usingOraclize {

    string public temperature;

    event LogNewOraclizeQuery(string description);
    event LogNewTemperatureMeasure(string temperature);

    function WolframAlpha() public {
        update(); // Update on contract creation...
    }

    function __callback(bytes32 myid, string memory result) public {
        if(msg.sender == oraclize_cbAddress())
        {   
            temperature = result;
         LogNewTemperatureMeasure(temperature);
        }
    }

    function update() public payable {
         LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer...");
        oraclize_query("WolframAlpha", "temperature in India");
    }
}