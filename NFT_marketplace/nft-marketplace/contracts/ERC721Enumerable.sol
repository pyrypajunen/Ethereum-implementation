// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {

    // total supply
    uint[] private _allTokens;

    // mapping from tokenId to position in _allTokens array
    mapping(uint => uint) private _allTokensIndex;

    // mapping of owner to list fo all owner token ids
    mapping(address => uint[]) private _ownedTokens;

    // mapping from token ID index of the owner tokens list
    mapping(uint => uint) private  _ownedTokensIndex;

    function _mint(address _to, uint _tokenId) internal override(ERC721) {
        super._mint(_to, _tokenId);
        // 1. All tokens to our totalSupply - to allTokens
        _addTokensToAllTokensEnumeration(_tokenId);
         // 2. add tokens to the owner
        _addTokenToOwnerEnumeration(_to, _tokenId);
    }

    function _addTokensToAllTokensEnumeration(uint _tokenId) private {
        // this will set up the token index
        _allTokensIndex[_tokenId] = _allTokens.length;
        _allTokens.push(_tokenId);
    }

    function _addTokenToOwnerEnumeration(address _to, uint tokenId) private {
        _ownedTokens[_to].push(tokenId);
        _ownedTokensIndex[tokenId] = _ownedTokens[_to].length;
    }

    function _tokenByIndex(uint _index) public view returns(uint) {
        require(_index < _totalSupply(), "Index is out of range!");
        return _allTokensIndex[_index];
    }

    function _tokenOfOwnerByIndex(address _owner, uint _index) public view returns(uint) {
        require(_index < balanceOf(_owner), "Owner index is out of range!");
        return _ownedTokens[_owner][_index];
    }

    function _totalSupply() public view returns(uint) {
        return _allTokens.length;
    }
    
}