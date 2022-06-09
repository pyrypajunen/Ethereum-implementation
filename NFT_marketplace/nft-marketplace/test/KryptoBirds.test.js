const {asesrt, assert} = require('chai');
const { FormControlStatic } = require('react-bootstrap');

const KryptoBird = artifacts.require("KryptoBird");


// check for chai
require('chai')
.use(require('chai-as-promised'))
.should()

// accounts its from ganache
contract('KryptoBird', (accounts) => {
    let contract;

    // testing container - describe
    describe('deployment', async () => {

        // test samples
        it('The addres should notEqual', async() => {
            contract = await KryptoBird.deployed()
            const contractAddress = contract.address;
            assert.notEqual(contractAddress, '');
            assert.notEqual(contractAddress, null);
            assert.notEqual(contractAddress, undefined);
            assert.notEqual(contractAddress, 0x0);
        })

        it("The name should be equal", async() => {
            const contractName = await contract.name();
            assert.equal(contractName, 'KryptoBird');
        })

        it("The symbol should be equal", async() => {
            const contractSymbol = await contract.symbol();
            assert.equal(contractSymbol ,'KBIRDZ')
        })
    })
})