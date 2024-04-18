const MyContract = artifacts.require("Ownable");

module.exports = function(deployer) {
    deployer.deploy(Ownable);
};