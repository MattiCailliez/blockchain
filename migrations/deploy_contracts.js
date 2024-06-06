console.log("1");
const contract = artifacts.require("Person");
console.log("2");
module.exports = function(deployer) {
deployer.deploy(contract).then(function() {
    console.log("Contract deployed successfully!");
});
};