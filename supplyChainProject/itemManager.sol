//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ItemManager {

    enum SuppleChainState{Created, Paid, Delivered} 

    struct S_item {
        string _identifier;
        uint _itemPrice;
        ItemManager.SuppleChainState _state;

    }

    mapping (uint => S_item) public items;
    uint itemIndex;

    event supplyChainStep(uint _itemIndex, uint _step);


    function createItem(string memory _identifier, uint _itemPrice) public {
        items[itemIndex]._identifier = _identifier;
        items[itemIndex]._itemPrice = _itemPrice;
        items[itemIndex]._state = SuppleChainState.Delivered;
        emit supplyChainStep(itemIndex, uint(items[itemIndex]._state));
        itemIndex++;

    }
    
    function triggerPayment(uint _itemIndex) public payable {
        require(items[_itemIndex]._itemPrice == msg.value, "Only full payments accepted");
        require(items[_itemIndex]._state == SuppleChainState.Created, "Item is futher in the chain.");
        items[_itemIndex]._state = SuppleChainState.Paid;
        emit supplyChainStep(_itemIndex, uint(items[_itemIndex]._state));

    }

    function triggerDelivery(uint _itemIndex) public {
        require(items[_itemIndex]._state == SuppleChainState.Paid, "Item is futher in the chain.");
        items[_itemIndex]._state = SuppleChainState.Delivered;
        emit supplyChainStep(_itemIndex, uint(items[_itemIndex]._state));


    }
}
