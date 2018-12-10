var Delegate = artifacts.require("./Delegate.sol");
var Delegation = artifacts.require("./Delegation.sol");

module.exports = function(deployer, network, accounts) {
    if (network=="development"){ 
        deployer.deploy(Delegate, accounts[0], {from:accounts[0]})
        .then(function(){
            return deployer.deploy(Delegation, Delegate.address, {from:accounts[0]});
        });
    }
};
