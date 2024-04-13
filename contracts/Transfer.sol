// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// SPDX-License-Identifier: MIT
import "./Ownable.sol";
import "./Property.sol";

contract Transfer is Ownable, Property {

  // Event for successful property transfer
  event OwnershipTransferred(uint256 propertyId, address from, address to);

  // Function to transfer ownership of a property (restricted by onlyOwner modifier)
  function transferOwnership(uint256 propertyId, address payable newOwner) public onlyOwner {
    // Verify ownership of the property being transferred (inherited from Property.sol)
    require(verifyOwnership(propertyId), "Unauthorized transfer attempt");

    // Update the owner address in the ipfsHashes mapping (inherited from Property.sol)
    ipfsHashes[propertyId] = ""; // Consider alternative for ownership tracking on IPFS (optional)

    // Update the owner in the PropertyDetails struct (consider alternative for ownership tracking on-chain)
    PropertyDetails storage details = getPropertyDetails(propertyId); // Placeholder, implement a function to retrieve details
    details.owner = newOwner;

    // Emit an event to record the ownership transfer
    emit OwnershipTransferred(propertyId, msg.sender, newOwner);
  }

  // Function to retrieve property details (placeholder, implement details based on your chosen approach)
  function getPropertyDetails(uint256 propertyId) public view returns (PropertyDetails storage) {
    // Replace with actual logic to retrieve property details from storage (on-chain or off-chain) based on your implementation
    revert("Not implemented"); // Placeholder to indicate functionality needs implementation
  }
}

