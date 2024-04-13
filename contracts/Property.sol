// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Ownable.sol";

contract Property is Ownable {

  // Define an enum to represent the verification status of a property
  enum VerificationStatus { NotVerified, Verified }

  // Define property details structure
  struct PropertyDetails {
    address owner;
    uint256 propertyId;
    uint256 area;
    string municipality;
    string addressLine1; // Combine room, floor, building/house name
    string street;
    string city;
    string state;
    string country;
  }

  // Mapping to store property details
  mapping(uint256 => PropertyDetails) public propertyDetails;

  // Mapping to store the IPFS hash associated with each property ID
  mapping(uint256 => bytes32) public ipfsHashes;

  // Mapping to store the verification status of each property
  mapping(uint256 => VerificationStatus) public verificationStatus;

  // Fallback function to prevent accidental sending of funds to the contract
  fallback() external payable {}

  // Function to add a property (restricted by onlyOwner modifier)
  function addProperty(
    uint256 propertyId,
    string memory details,
    bytes calldata signature
  ) public onlyOwner {
    // Off-chain verification using signed message (example)
    // Replace with your actual verification service and message format
    require(verifyOwnership(propertyId, signature), "Unauthorized property addition");
    require(verificationStatus[propertyId] == VerificationStatus.NotVerified, "Property already verified");
    bytes32 ipfsHash = storeDetailsOnIPFS(details); // Upload details to IPFS
    ipfsHashes[propertyId] = ipfsHash;
    propertyDetails[propertyId] = PropertyDetails(msg.sender, propertyId, 0, "", "", "", "", "", ""); // Placeholder for details retrieval (see note)
    verificationStatus[propertyId] = VerificationStatus.Verified;
    emit PropertyAdded(propertyId, ipfsHash);
  }

  // Function to verify ownership using a signed message (example)
  function verifyOwnership(uint256 propertyId, bytes calldata signature) public view returns (bool) {
    // Replace with your actual verification service logic
    // 1. Recover signer address from the signature and message (propertyId)
    address signer = recoverSigner(signature, keccak256(abi.encodePacked(propertyId)));
    // 2. Verify if the signer address is authorized for this propertyId (interact with your verification service)
    // This could involve checking a database or trusted service that confirms ownership based on propertyId
    return isAuthorized(signer, propertyId); // Placeholder, replace with actual verification logic
  }

  // Function to recover signer address from signature and message (placeholder)
  function recoverSigner(bytes calldata signature, bytes32 messageHash) public pure returns (address) {
    // Replace with a library function for signature verification and signer recovery (e.g., ECDSA)
    return address(0); // Placeholder, replace with actual signature verification logic
  }

  // Function to check if signer is authorized for the property (placeholder)
  function isAuthorized(address signer, uint256 propertyId) public view returns (bool) {
    // Replace with logic to interact with your verification service (e.g., calling a trusted service)
    // This service would check your legacy MySQL database and confirm ownership based on propertyId and signer address
    return false; // Placeholder, replace with actual verification logic
  }

  // Function to store details on IPFS (implementation details depend on the chosen IPFS library)
  function storeDetailsOnIPFS(string memory details) internal returns (bytes32) {
    // Replace with actual IPFS storage logic using a chosen library
    // This could involve using an IPFS gateway or dedicated library to interact with the IPFS network
    return bytes32(keccak256(abi.encodePacked(details))); // Placeholder, replace with actual IPFS storage logic
  }

  // Function to retrieve property details (consider security best practices)
  function getPropertyDetails(uint256 propertyId) public view returns (PropertyDetails memory) {
    require(verificationStatus[propertyId] == VerificationStatus.Verified, "Property not verified");

    // Option 1: Retrieve details from off-chain storage (recommended for sensitive data)
    // Replace with logic to interact with your off-chain database using an oracle or similar mechanism
    // This approach keeps sensitive property details off-chain and only exposes verification status and IPFS hash on-chain.
    // return retrieveDetailsFromOffchainStorage(propertyId); // Placeholder, implement off-chain retrieval

    // Option 2: Retrieve details from on-chain storage (consider gas costs and data size limitations)
    // This approach stores property details on-chain but might be less efficient and have limitations on data size.
    // return propertyDetails[propertyId]; // Placeholder, replace with direct access if stored on-chain

    revert("No implementation for property details retrieval"); // Placeholder to indicate functionality needs implementation based on your chosen approach
  }

  // Function to retrieve details from off-chain storage (placeholder, implement details based on your chosen approach)
  function retrieveDetailsFromOffchainStorage(uint256 propertyId) internal view returns (PropertyDetails memory) {
    // Replace with logic to interact with your off-chain database using an oracle or similar mechanism
    // This function would retrieve details from your database based on the property ID
    revert("Not implemented"); // Placeholder, replace with actual off-chain retrieval logic
  }
}