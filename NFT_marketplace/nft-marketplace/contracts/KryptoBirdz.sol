// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract KryptoBird is ERC721Connector {

    // array to store our nfts
    string [] public kryptoBirdz;

    mapping (string => bool) _kryptoBirdzExists;

    constructor() ERC721Connector('KryptoBird','KBIRDZ') {}

                                // _kryptoBird will be the data location.
    function mint(string memory _kryptoBird) public {
        // check if kryptobird are already minted
        require(!_kryptoBirdzExists[_kryptoBird], "Error - kryptoBird already exists");
        kryptoBirdz.push(_kryptoBird);
        uint _id = kryptoBirdz.length - 1;
        _mint(msg.sender, _id);
        _kryptoBirdzExists[_kryptoBird] = true;
    }

}


