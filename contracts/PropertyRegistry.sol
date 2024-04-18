// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract PropertyRegistry is Ownable {
    struct PropertyDetails {
        address owner;
    }

    mapping(uint256 => PropertyDetails) public properties;

    function registerProperty(uint256 propertyId, address newOwner) public onlyOwner {
        require(properties[propertyId].owner == address(0), "Property already registered");
        properties[propertyId].owner = newOwner;
    }

    function transferOwnership(uint256 propertyId, address newOwner) public {
        require(properties[propertyId].owner == msg.sender, "Caller is not the owner of the property");
        properties[propertyId].owner = newOwner;
    }

    function getPropertyOwner(uint256 propertyId) public view returns (address) {
        return properties[propertyId].owner;
    }
}