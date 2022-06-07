// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Metadata.sol';
import './ERC721Enumerable.sol';

// this is a connector which combine all contracts together.
contract ERC721Connector is ERC721Metadata, ERC721Enumerable {
    
    constructor(string memory name, string memory symbol) ERC721Metadata(name, symbol) {
        

    }
}
