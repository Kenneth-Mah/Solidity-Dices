pragma solidity ^0.5.0;
import "./Dice.sol";

/*
1. First create dice using the Dice contract
2. Transfer both die to this contract using the contract's address
3. Use setBattlePair from each player's account to decide enemy
4. Use the battle function to roll, stop rolling and then compare the numbers
5. The player with the higher number gets BOTH dice
6. If there is a tie, return the dice to their previous owner
*/


contract DiceBattle {
    Dice diceContract;
    mapping(address => address) battle_pair;

    constructor(Dice diceAddress) public {
        diceContract = diceAddress;
    }

    function setBattlePair(address enemy) public {
        // Require that only prev owner can allow an enemy
        // Each player can only select one enemy
        
    }

    function battle(uint256 myDice, uint256 enemyDice) public {
        // Require that battle_pairs align, ie each player has accepted a battle with the other

        // Run battle

    }

    //Add relevant getters and setters
}