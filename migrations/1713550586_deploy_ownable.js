const Ownable = artifacts.require("Ownable");

module.exports = function(_deployer) {
  _deployer.deploy(Ownable);
};
