pragma solidity ^0.5.0;

import "./ERC20.sol";

contract DiceToken {
    ERC20 erc20Contract;
    uint256 supplyLimit;
    uint256 currentSupply;
    address owner;
    
    constructor() public {
        ERC20 e = new ERC20();
        erc20Contract = e;
        owner = msg.sender;
        supplyLimit = 10000;

    }


    function getCredit() public payable {
        uint256 amt = msg.value / 10000000000000000; // Get DTs eligible
        require(erc20Contract.totalSupply() + amt < supplyLimit, "DT supply is not enough");
        // erc20Contract.transferFrom(owner, msg.sender, amt);
        erc20Contract.mint(msg.sender, amt);
        
    }

    function checkCredit() public view returns(uint256) {
        return erc20Contract.balanceOf(msg.sender);
    }

}