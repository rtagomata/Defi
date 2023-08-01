//SPDX-License-Identifier: MIT

contract Donate 
{
    address public owner;

    constructor()
    {
        owner = payable(msg.sender);
    }

    receive() external payable{}

    modifier onlyOwner
    {
        require(msg.sender == owner);
        _;
    }

    function withdraw() payable public onlyOwner
    {
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Failed to withdraw");
    }
}