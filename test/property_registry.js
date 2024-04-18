const PropertyRegistry = artifacts.require("PropertyRegistry");

contract("PropertyRegistry", (accounts) => {
    let propertyRegistryInstance;
    const owner = accounts[0];
    const nonOwner = accounts[1];
    const propertyId = 1;
    const newOwner = accounts[2];

    beforeEach(async () => {
      propertyRegistryInstance = await PropertyRegistry.new({ from: owner });
    });

    it("should allow owner to register a new property", async () => {
        await propertyRegistryInstance.registerProperty(propertyId, owner, { from: owner });
        const propertyOwner = await propertyRegistryInstance.getPropertyOwner(propertyId);
        assert.equal(propertyOwner, owner, "Owner address should match registered owner");
    });

    it("should restrict property registration to only the contract owner", async () => {
        try {
            await propertyRegistryInstance.registerProperty(propertyId, owner, { from: nonOwner });
            assert.fail("Function call should have reverted");
        } catch (error) {
            assert.include(error.message, "Only owner can call this function", "Error message should indicate access restriction");
        }
    });

    it("should allow owner to transfer ownership of a property", async () => {
        await propertyRegistryInstance.registerProperty(propertyId, owner, { from: owner });
        await propertyRegistryInstance.transferOwnership(propertyId, newOwner, { from: owner });
        const propertyOwner = await propertyRegistryInstance.getPropertyOwner(propertyId);
        assert.equal(propertyOwner, newOwner, "Owner address should be updated after transfer");
    });

    it("should restrict property ownership transfer to the current owner", async () => {
        await propertyRegistryInstance.registerProperty(propertyId, owner, { from: owner });
        try {
            await propertyRegistryInstance.transferOwnership(propertyId, newOwner, { from: nonOwner });
            assert.fail("Function call should have reverted");
        } catch (error) {
            assert.include(error.message, "Caller is not the owner of the property", "Error message should indicate access restriction");
        }
    });
});
