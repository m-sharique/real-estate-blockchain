const Property = artifacts.require("Property");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Property", function (/* accounts */) {
  it("should assert true", async function () {
    await Property.deployed();
    return assert.isTrue(true);
  });
});
