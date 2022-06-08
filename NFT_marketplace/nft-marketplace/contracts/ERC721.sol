// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Here are the ERC721 standards ONLY!
contract ERC721 {

    // remember 3 indexed keyword are MAX per event! 
    // save gas as much as possible-
    event Transfer(
        address indexed from, 
        address indexed to, 
        uint indexed tokenId);

    event Approval(
        address indexed owner, 
        address indexed approved,
        uint256 indexed tokenId);


    event ApprovalForAll( 
        address indexed owner, 
        address indexed operator, 
        bool indexed approved);

    // mapping for token id to the owner
    mapping(uint => address) private _tokenOwner;

    // mapping from owner to number of owned tokens
    mapping(address => uint) private _ownedTokensCount;

    // mapping from token id to approval addresses
    mapping(uint => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    function _exists(uint _tokenId) internal view returns(bool) {
        // setting the address of nft owner to check the mapping
        // of the address from tokenOwner at the tokenId
        address owner = _tokenOwner[_tokenId];
        // return truth that address is not zero
        return owner != address(0);
    }

    function _mint(address _to, uint _tokenId) internal virtual {
        require(_to != address(0), "Error - ERC721: minting to the zero address");
        // Check if the token is already minted
        require(!_exists(_tokenId), "Error - ERC721: token already minted");
        // this will give an address to token
        _tokenOwner[_tokenId] = _to;
        // add 1 for user owned tokens
        _ownedTokensCount[_to] +=1;
        emit Transfer(address(0), _to, _tokenId);

    }

    function balanceOf(address _owner) public view returns(uint) {
        require(_owner != address(0), 'Error - Owner query for non-existent token');
        return _ownedTokensCount[_owner];
    }

    function ownerOf(uint _tokenId) public   view returns(address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'Error - Owner query for non-existent token');
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

    function transferFrom(address from, address to, uint tokenId) public payable {
        require(_isApprovedOrOwner(msg.sender, tokenId), "Error - It's not approved or owner");
        _transferFrom(from, to, tokenId);
    }

    function setApprovalForAll(address operator, bool approved) public  {
        require(operator != msg.sender, "ERC721: approve to caller");
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner, "Error - approval to current owner");
        require(msg.sender == owner, "Error - Current caller is not the owner of the token");
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    function getApproved(uint256 tokenId) public view returns(address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");
        return _tokenApprovals[tokenId];
    }

    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns(bool) {
        require(_exists(tokenId), "Token does not exist");
        address owner = ownerOf(tokenId);
        return(spender == owner || spender == getApproved(tokenId) || isApprovedForAll(owner, spender));
    }
}