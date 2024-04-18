const MyContract = artifacts.require("PropertyRegistration");

module.exports = function(deployer) {
    deployer.deploy(PropertyRegistration);
};