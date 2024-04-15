// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

// Structure to store property details retrieved from verification
struct PropertyDetails {
  address owner;
  uint256 propertyId;
  string memory street;
  string memory city;
  string memory state;
  string memory postalCode;
  string memory country;
}

contract Property is ChainlinkClient, ConfirmedOwner {
  using Chainlink for Chainlink.Request;

  // Replace with your actual oracle address and job ID obtained from Chainlink
  address public oracleAddress;
  bytes32 public verifyOwnershipJobId;

  // Mapping to store property details
  mapping(uint256 => PropertyDetails) public propertyDetails;

  // Event emitted when a property is added
  event PropertyAdded(uint256 propertyId);

  // Function to add a property
  function addProperty(
    uint256 propertyId,
    bytes calldata signature
  ) public onlyOwner {
    // Off-chain verification using Chainlink oracle
    Chainlink.Request memory req = buildVerifyOwnershipRequest(
      propertyId,
      signature
    );
    sendChainlinkRequestTo(oracleAddress, req, verifyOwnershipJobId);
  }

  // Function to build the Chainlink request for verification
  function buildVerifyOwnershipRequest(uint256 propertyId, bytes calldata signature)
    public
    pure
    returns (Chainlink.Request memory)
  {
    // Replace with your actual oracle function and parameters based on your API call
    bytes memory payload = abi.encodePacked(propertyId, signature);
    return requestOracleData(verifyOwnershipJobId, payload);
  }

  // Callback function called by Chainlink after verification
  function fulfillVerifyOwnership(bytes32 requestId, bool isVerified) public recordChainlinkFulfillment(requestId) {
    require(isVerified, "Unauthorized property addition");

    propertyDetails[propertyId] = PropertyDetails(msg.sender, propertyId, "", "", "", "", ""); // Placeholder details (replace if needed)
    emit PropertyAdded(propertyId);
  }
}