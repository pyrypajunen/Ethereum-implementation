//SPDX-License-Identifier: MIT
 
pragma solidity ^0.6.0;

import "./ItemManager.sol";

contract Item {

    uint public priceInWei;
    uint public pricePaid;
    uint public index;

    ItemManager parentContract;

    constructor(ItemManager _parentContract, uint _priceInWei, uint _index)  public {
        parentContract = _parentContract;
        priceInWei = _priceInWei;
        index = _index;
    }

    receive() external payable {
        require(pricePaid == 0, "Item is already paid!");
        require(priceInWei == msg.value, "We dont support partial payments");
        pricePaid += msg.value;
        (bool succees, ) = address(parentContract).call.value(msg.value)(abi.encodeWithSignature("triggerPayment(uint256)", index));
        require(succees, "Payment wasn't succesful, canceling...");
    }

    fallback() external payable {}
}