// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Property.sol"; // Assuming Property.sol is in the same directory

contract Transfer {

  Property public propertyContract;  // Instance of the Property contract

  constructor(address _propertyContract) {
    propertyContract = Property(_propertyContract);
  }

  // Function to transfer ownership (assuming verified off-chain)
  function transferProperty(uint256 propertyId, address newOwner) public {
    require(propertyContract.propertyDetails(propertyId).owner == msg.sender, "Not authorized for transfer");

    // Assuming off-chain verification has already confirmed new owner
    propertyContract.propertyDetails[propertyId].owner = newOwner;

    // Emit an event to notify about the transfer
    emit PropertyTransferred(propertyId, msg.sender, newOwner);
  }

  // Event emitted when a property is transferred
  event PropertyTransferred(uint256 propertyId, address oldOwner, address newOwner);
}
