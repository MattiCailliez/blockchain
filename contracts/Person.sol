// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import ownable and safemath contract
import "./ownable.sol";
import "./safemath.sol";

// Import battlke token contract
import "./BattleToken.sol";

// Define contract as an extension of the battle token contract
contract Person is BattleToken {
    // Use safe math for simple math
    using SafeMath16 for uint16;

    // Define an enum for the gender of a person
    enum Gender {
        Male,
        Female
    }

    // Define the struc tof a person with all of its characteristics (uint16 are scores from 1 to 10 except age)
    struct Fighter {
        uint id;
        uint16 intelligence;
        uint16 strength;
        uint16 stamina;
        uint16 experience;
        Gender gender;
    }

    // Set the name and the symbol of the contarct
    string public constant name = "Person Token";
    string public constant symbol = "PTT";

    // Array of all persons
    Fighter[] public fighters;

    // Mapping to keep track of who owns which person and a mapping to see how many people a user has
    mapping(uint => address) public fighterToOwner;
    mapping(address => uint16) private ownerFightersCount;

    // Mapping of the fighter the user showcases to for fighting
    mapping(address => Fighter) fighterToUser;

    address public ownerContract;

    constructor() {
        ownerContract = msg.sender;
    }

    // Function to create a fighter
    function _createFighter(address owner) internal returns (Fighter memory) {
        uint id = fighters.length;

        Fighter memory fighter = Fighter(
            _generateRandomDna(),
            createStat(),
            createStat(),
            createStat(),
            createStat(),
            getRandomGender()
        );

        fighters.push(fighter);
        fighterToOwner[id] = owner;
        ownerFightersCount[owner] = ownerFightersCount[owner].add(uint16(1));

        return fighter;
    }

    // Function to create random stat from 1 to 10 for the characteristics of a person
    function createStat() private view returns (uint16) {
        return
            uint16(
                (uint256(
                    keccak256(abi.encodePacked(block.timestamp, msg.sender))
                ) % 10) + 1
            );
    }

    // Function to create random gender
    function getRandomGender() private view returns (Gender) {
        uint16 rand = createStat();
        if (rand >= 1 && rand <= 5) {
            return Gender.Male;
        } else {
            return Gender.Female;
        }
    }

    // Function to create random dna
    function _generateRandomDna() private pure returns (uint) {
        return uint(keccak256(abi.encodePacked("Fighter"))) % (10 ** 16);
    }

    // Function to determine odds of winning
    function _getOdds(Fighter storage fighter) private view returns (uint16) {
        uint16 genderOdds = fighter.gender == Gender.Male ? 7 : 3;

        return
            fighter.experience +
            fighter.intelligence +
            fighter.stamina +
            fighter.strength +
            genderOdds;
    }

    // Function to simulate a battle (it returns if the first fighter won or not -> first fighter is the attacker)
    function _battleSimulation(
        uint _fighter1,
        uint _fighter2
    ) private view returns (bool) {
        uint16 odds1 = _getOdds(fighters[_fighter1]);
        uint16 odds2 = _getOdds(fighters[_fighter2]);

        if (_winningNumber(odds1 + odds2) > odds1) return false;
        return true;
    }

    // Function to generate random number between 1 and the number of totalodds between a battle
    function _winningNumber(uint16 odds) private view returns (uint16) {
        return
            uint16(
                (uint256(
                    keccak256(abi.encodePacked(block.timestamp, msg.sender))
                ) % odds) + 1
            );
    }

    function _battle(uint _fighter1, uint _fighter2) private returns (bool) {
        // Check if use has battle tokens
        require(tokensUser[address(this)] > 0, "No battle tokens.");

        bool win = _battleSimulation(_fighter1, _fighter2);

        if (win) {
            _createFighter(address(this));
        }

        useToken();

        return win;
    }

    function getFightersByOwner() external view returns (uint[] memory) {
        uint[] memory result = new uint[](ownerFightersCount[msg.sender]);
        uint counter = 0;
        for (uint i = 0; i < fighters.length; i++) {
            if (fighterToOwner[i] == msg.sender) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    modifier isTheOwner() {
        require(msg.sender == ownerContract, "Caller is not the owner");
        _;
    }

    function changeOwnership(address newOwner) public isTheOwner {
        require(newOwner != address(0), "Invalid new owner address");
        ownerContract = newOwner;
    }
}
