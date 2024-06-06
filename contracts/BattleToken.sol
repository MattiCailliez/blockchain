// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import ownable contract
import "./ownable.sol";

contract BattleToken is Ownable {
    // Set the prize of a battle token
    uint256 public constant PRICE = 1;

    // Mapping to keep track of how many battle token a user has
    mapping(address => uint) public tokensUser;

    // Function to buy a battle token using person currency
    function buyToken() external payable {
        // Check if the correct amount of tokens was sent
        require(msg.value == PRICE, "Incorrect amount of PTT sent.");

        // Add a token to the amount of tokens the user has
        tokensUser[address(this)]++;
    }

    // Function to use a battle token
    function useToken() public {
        tokensUser[address(this)]--;
    }
}
