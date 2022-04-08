//SPDX-License-Identifier: MIT

pragma solidity 0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "./allowance.sol";

contract SharedWallet is Allowance {

    event moneySent(address indexed _beneficiary, uint _amount);
    event moneyReceived(address indexed _from, uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance, "Contract doesn't own enough money");
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit moneySent(_to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() override public onlyOwner {
        revert("Can't renounce ownership here!");
    }

    receive() external payable {
        emit moneyReceived(msg.sender, msg.value);
    }
}
