// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Here are the ERC721 standards ONLY!
contract ERC721 {

    // remember 3 indexed keyword are MAX per event! 
    // save gas as much as possible-
    event Transfer(
        address indexed _from, 
        address indexed _to, 
        uint indexed tokenId);

    // mapping for token id to the owner
    mapping(uint => address) private _tokenOwner;

    // mapping from owner to number of owned tokens
    mapping(address => uint) private _ownedTokensCount;

    // mapping from token id to approval addresses
    mapping(uint => address) private _tokenApprovals;

    function _exists(uint _tokenId) internal view returns(bool) {
        // setting the address of nft owner to check the mapping
        // of the address from tokenOwner at the tokenId
        address owner = _tokenOwner[_tokenId];
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

    function ownerOf(uint _tokenId) public   view returns(address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'Owner query for non-existent token');
        return owner;
    }

    function _transferFrom(address _from, address _to, uint _tokenId) internal {
        require(_to != address(0), 'Error - ERC721 transfer to the zero address ');
        require(ownerOf(_tokenId) == _from, "Error - Trying to transfer a token the address does not own");
        _ownedTokensCount[_from] -= 1;
        _ownedTokensCount[_to] += 1;
        _tokenOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
        
    }

    function transferFrom(address _from, address _to, uint _tokenId) public payable {
        _transferFrom(_from, _to, _tokenId);
    }


}