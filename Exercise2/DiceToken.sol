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
        erc20Contract.mint(msg.sender, amt);
    }

    function checkCredit() public view returns (uint256) {
        return erc20Contract.balanceOf(msg.sender);
    }

    function transferCredit(address to, uint256 value) public {
        erc20Contract.transfer(to, value);
    }

    function transferCreditFrom(address from, address to, uint256 value) public {
        erc20Contract.transferFrom(from, to, value);
    }

    function approveCredit(address spender, uint256 value) public {
        erc20Contract.approve(spender, value);
    }

    function allowanceCredit(address creditOwner, address spender) public view returns (uint256) {
        return erc20Contract.allowance(creditOwner, spender);
    }
}