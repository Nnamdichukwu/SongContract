const SongContract = artifacts.require("SongContract");


module.exports = function(deployer) {
  deployer.deploy(SongContract);
 
};
