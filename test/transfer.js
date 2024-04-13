const Transfer = artifacts.require("Transfer");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Transfer", function (/* accounts */) {
  it("should assert true", async function () {
    await Transfer.deployed();
    return assert.isTrue(true);
  });
});
