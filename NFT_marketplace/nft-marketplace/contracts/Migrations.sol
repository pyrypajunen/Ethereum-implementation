// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Migrations {
  address public owner = msg.sender;
  uint public last_completed_migration;

  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  // Make a new contract and set a new owner
  function upgrade(address _new_address) public restricted {
    // making a new contract of Migrations
    Migrations upgraded = Migrations(_new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
