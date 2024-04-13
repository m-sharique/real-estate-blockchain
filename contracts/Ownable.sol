// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Ownable {

  // Define an address variable named 'owner' to store the contract owner's address
  address public owner;

  // Constructor function that gets called automatically when the contract is deployed
  constructor() {
    // Set the 'owner' variable to the address of the person who deployed the contract (msg.sender)
    owner = msg.sender;
  }

  // Define a modifier named 'onlyOwner'
  modifier onlyOwner() {
    // Require that the function caller's address (msg.sender) must be equal to the 'owner' variable
    require(msg.sender == owner, "Only owner can call this function");
    // If the above condition is true, the rest of the code within the function will be executed (indicated by the underscore '_')
    _;
  }
}
