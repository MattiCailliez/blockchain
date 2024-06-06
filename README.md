# Read me "Battle Game"

## Overview

The Battle Game project is a blockchain-based game built on Ethereum where users can create and own fighters, represented as ERC-721 tokens. Users can battle their fighters against each other to win new fighters. The project comprises three Solidity contracts (`Person.sol`, `BattleToken.sol`, `Ownable.sol`) and a front-end web application built with HTML and Web3.js.

## Project Structure

### Contracts

#### Ownable.sol

This contract provides basic authorization control functions, simplifying the implementation of user permissions. It includes:

- `owner`: Stores the address of the contract owner.
- `onlyOwner` modifier: Ensures that only the owner can call specific functions.
- Functions to transfer and renounce ownership.

#### BattleToken.sol

This contract extends the `Ownable` contract and manages the battle tokens used in the game. It includes:

- `PRICE`: The price of a battle token.
- `tokensUser`: A mapping to track the number of tokens each user has.
- Functions to buy and use tokens.

#### Person.sol

This contract extends the `BattleToken` contract and represents the core functionality of the game. It includes:

- Enum `Gender`: Represents the gender of a fighter.
- Struct `Fighter`: Represents a fighter with attributes like intelligence, strength, stamina, experience, and gender.
- `fighters`: An array of all fighters.
- `fighterToOwner`: A mapping to track fighter ownership.
- `ownerFightersCount`: A mapping to track the number of fighters owned by a user.
- Functions to create fighters, generate random attributes, simulate battles, and manage ownership.

### Front-End

#### index.html

This file provides the front-end interface for the game. It includes:

- Web3.js library: To interact with the Ethereum blockchain.
- JavaScript to initialize the app and connect to the Ethereum network using MetaMask.
- Functions to get the fighters owned by a user.

## Contract Logic

### Ownable.sol

1. **Owner Management**: The contract sets the deployer as the initial owner and provides functions to transfer and renounce ownership.

### BattleToken.sol

1. **Token Management**: Users can buy battle tokens by sending ETH. Tokens are tracked per user and can be used in battles.

### Person.sol

1. **Fighter Creation**: Fighters are created with random attributes using the `_createFighter` function, which generates random DNA, stats, and gender.
2. **Battle Logic**: The `_battle` function simulates a battle between two fighters, determining the winner based on their attributes and a random factor.
3. **Ownership Tracking**: The contract tracks the ownership of fighters and allows querying of fighters owned by a user.

## Front-End Logic

1. **Initialization**: The app checks for the presence of MetaMask and initializes the `personContract` instance with the deployed contract address.
2. **Interaction**: Users can interact with the contract to retrieve their fighters using the `getFighterByOwner` function.

## Usage

1. **Deploy Contracts**: Deploy `Ownable.sol`, `BattleToken.sol`, and `Person.sol` on the Ethereum network.
2. **Set Up Front-End**: Host the `index.html` file on a web server.
3. **Connect with MetaMask**: Ensure MetaMask is installed and connected to the Ethereum network.
4. **Interact with the Game**: Use the web interface to create fighters, buy tokens, and engage in battles.

## Notes

- Ensure the contract addresses are correctly set in the front-end JavaScript.
- Adequate error handling should be added for a production-ready application.
