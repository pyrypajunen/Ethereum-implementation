//SPDX-License-Identifier: MIT
 
pragma solidity ^0.6.0;

import "./Ownable.sol";
import "./Item.sol";


contract ItemManager is Ownable {

    // Keeps track which are the current state
    enum SuppleChainState{Created, Paid, Delivered} 

    // this stuck stores information about the item, such as _identfier, _itemPrice and enum SupplyChainState.
    struct S_item {
        Item _item;
        string _identifier;
        uint _itemPrice;
        ItemManager.SuppleChainState _state;
    }
 

    mapping (uint => S_item) public items;
    uint itemIndex;

    event supplyChainStep(uint _itemIndex, uint _step);


    function createItem(string memory _identifier, uint _itemPrice) public onlyOwner {
        Item item = new Item(this, _itemPrice, itemIndex);
        items[itemIndex]._item = item;
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

    function triggerDelivery(uint _itemIndex) public  onlyOwner {
        require(items[_itemIndex]._state == SuppleChainState.Paid, "Item is futher in the chain.");
        items[_itemIndex]._state = SuppleChainState.Delivered;
        emit supplyChainStep(_itemIndex, uint(items[_itemIndex]._state));


    }
}