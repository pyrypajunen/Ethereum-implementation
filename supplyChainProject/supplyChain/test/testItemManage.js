const ItemManager = artifacts.require("./ItemManager.sol");  

contract("ItemManager", accounts => {
    it("...it should be able to add an Item", async() => {
        const itenManagerInstance =  await ItemManager.deployed();
        const itemName = "TestItem";
        const itemPrice = 500;

        const result =  await itenManagerInstance.createItem(itemName, itemPrice, {from: accounts[0]});
        assert.equal(result.logs[0].args._itemIndex, 0, "There should be one item index in there");

        const item = await itenManagerInstance.items(0);
        assert.equal(item._identifier , itemName, "The identifier was different!");

    })
});