const contract = artifacts.require("Person");
const contract2 = artifacts.require("BattleToken");

module.exports = function(deployer) {
    deployer.deploy(contract);
    deployer.deploy(contract2);
};