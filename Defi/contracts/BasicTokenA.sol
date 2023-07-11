//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//First token for testing
contract BasicTokenA is ERC20
{
    constructor(uint256 initialSupply) ERC20("BasicTokenA", "BTA") 
    {
        _mint(msg.sender, initialSupply);
    }
}   