var TerraDrop = artifacts.require("./TerraDrop.sol");
var Cache = artifacts.require("./Cache.sol");

module.exports = function(deployer) {
  deployer.deploy(TerraDrop);
};