const PropertyRegistry = artifacts.require("PropertyRegistry");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("PropertyRegistry", function (/* accounts */) {
  it("should assert true", async function () {
    await PropertyRegistry.deployed();
    return assert.isTrue(true);
  });
});
