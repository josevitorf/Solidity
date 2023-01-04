// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.4;

contract CrypToken{
    address public minter;

    mapping(uint256=>address) public tokenOwner;

    mapping(address=>uint256) public ownerTokenBalance;

    event Sent(address from, address to, uint256 tokenId);
    
    constructor(){
        minter = msg.sender;
    }

    function _exists(uint256 tokenId) public view returns(bool){
        address owner = tokenOwner[tokenId];
        return owner != address(0);
    }

    function mint(uint256 tokenId)public{
        require(!_exists(tokenId), "ERROR: Token ja Existe");
        require(msg.sender == minter);
        tokenOwner[tokenId] = msg.sender;
        ownerTokenBalance[msg.sender] += 1;
    }

    function _ownerOf(uint256 tokenId) internal view returns(address){
        address owner = tokenOwner[tokenId];
        require(owner != address(0), "ERROR TOKEN e INvalido");
        return owner;
    }

    function send(address receiver, uint256 tokenId)public{
        require(_ownerOf(tokenId) == msg.sender);
        require(receiver != address(0), "ERROR: Receiver Invalido");
        tokenOwner[tokenId] = receiver;
        ownerTokenBalance[receiver] +=1;
        ownerTokenBalance[msg.sender] -=1;

        emit Sent(msg.sender, receiver, tokenId);
    }

}