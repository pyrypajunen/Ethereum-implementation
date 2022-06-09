// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './interfaces/IERC165.sol';

contract ERC165 is IERC165 {

    mapping(bytes4 => bool) private _supportInterFaces;

    constructor() {
        _registerInterface(bytes4(keccak256('supportsInterface(bytes4)')));
    }

    function supportsInterface(bytes4 interfaceID) external view returns (bool) {
        return _supportInterFaces[interfaceID];
    }

    // registeting the interface 
    function _registerInterface(bytes4 interfaceID) public  {
        require(interfaceID != 0xffffffff, "Error - ERC165: Invalid interface");
        _supportInterFaces[interfaceID] = true;
    }


}