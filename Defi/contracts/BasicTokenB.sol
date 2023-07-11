//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//Second token to use for testing
contract BasicTokenA is ERC20
{
    constructor(uint256 initialSupply) ERC20("BasicTokenB", "BTB") 
    {
        _mint(msg.sender, initialSupply);
    }
}   