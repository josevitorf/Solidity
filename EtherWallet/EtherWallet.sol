// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract EtherWallet{
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    function withdraw(uint256 amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(owner).transfer(amount);
    }

    function getBalance() external view returns(uint256){
        return address(this).balance;
    }
}