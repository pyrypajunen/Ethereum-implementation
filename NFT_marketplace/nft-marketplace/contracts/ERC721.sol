// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract ERC721 {

    // remember 3 indexed keyword are MAX per event! 
    // save gas as much as possible-
    event Transfer(
        address indexed _from, 
        address indexed _to, 
        uint indexed tokenId);

    // mapping for token id to the owner
    mapping(uint => address) private _tokenOwner;

    // Mapping from owner to number of owned tokens
    mapping(address => uint) private _ownedTokensCount;

    function _exists(uint toeknID) internal view returns(bool) {
        // setting the address pf nft owner to check the mapping
        // of the address from tokenOwner at the tokenId
        address owner = _tokenOwner[toeknID];
        // return truth that address is not zero
        return owner != address(0);
    }

    function _mint(address _to, uint _tokenId) internal virtual {
        require(_to != address(0), "ERC721: minting to the zero address");
        // Check if the token is already minted
        require(!_exists(_tokenId), "ERC721: token already minted");
        // this will give an address to token
        _tokenOwner[_tokenId] = _to;
        // add 1 for user owned tokens
        _ownedTokensCount[_to] +=1;
        emit Transfer(address(0), _to, _tokenId);

    }

    function balanceOf(address _owner) public view returns(uint) {
        require(_owner != address(0), 'Owner query for non-existent token');
        return _ownedTokensCount[_owner];
    }

    function ownerOf(uint _tokenId) external view returns(address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'Owner query for non-existent token');
        return owner;
    }

}