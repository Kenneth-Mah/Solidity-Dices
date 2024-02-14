pragma solidity ^0.5.0;

import "./Dice.sol";
import "./DiceToken.sol";

contract DiceMarket {

    Dice diceContract;
    DiceToken diceTokenContract;
    uint256 public comissionFee;
    address _owner = msg.sender;
    mapping(uint256 => uint256) listPrice;

    constructor(Dice diceAddress, DiceToken diceTokenAddress, uint256 fee) public {
        diceContract = diceAddress;
        diceTokenContract = diceTokenAddress;
        comissionFee = fee;
    }

    //list a dice for sale
    function list(uint256 id, uint256 price) public {
        require(msg.sender == diceContract.getPrevOwner(id));
        listPrice[id] = price;
    }

    function unlist(uint256 id) public {
        require(msg.sender == diceContract.getPrevOwner(id));
        listPrice[id] = 0;
    }

    // get price of dice
    function checkPrice(uint256 id) public view returns (uint256) {
        return listPrice[id];
    }

    // Buy the dice at the requested price
    function buy(uint256 id) public {
        require(listPrice[id] != 0); //is listed

        diceTokenContract.transferCreditFrom(msg.sender, diceContract.getPrevOwner(id), listPrice[id] - comissionFee);
        diceTokenContract.transferCreditFrom(msg.sender, address(this), comissionFee);

        diceContract.transfer(id, msg.sender);
    }

    function getContractOwner() public view returns(address) {
        return _owner;
    }

    function withDraw() public {
        if(msg.sender == _owner) {
            uint256 balance = diceTokenContract.checkCredit();
            diceTokenContract.transferCredit(msg.sender, balance);
        }
    }
}
