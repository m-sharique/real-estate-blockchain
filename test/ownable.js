const Ownable = artifacts.require("Ownable");

contract("Ownable", (accounts) => {
    let ownableInstance;
    const owner = accounts[0];
    const nonOwner = accounts[1];

    beforeEach(async () => {
      ownableInstance = await Ownable.new({ from: owner });
    });
  

    it("should set the owner to the deployer address after deployment", async () => {
        const contractOwner = await ownableInstance.owner();
        assert.equal(contractOwner, owner, "Owner address should match deployer");
    });

    it("should restrict access to only the contract owner", async () => {
        try {
            await ownableInstance.someFunction({ from: nonOwner });
            assert.fail("Function call should have reverted");
        } catch (error) {
            assert.include(error.message, "Only owner can call this function", "Error message should indicate access restriction");
        }
    });
});
