var Telephone = artifacts.require("./Telephone.sol");
var CallTelephone = artifacts.require("./CallTelephone.sol");

module.exports = function(deployer, network, accounts) {
    if (network=="development"){        
        // See: https://github.com/trufflesuite/truffle/issues/501#issuecomment-332589663
        // Deployer.link() returns a reference to a promise
        deployer.deploy(Telephone, {from:accounts[0]})
        // needed only when using library
        // deployer.link(Telephone, CallTelephone)
        // so we chain it with another reference to promise: deployer.deploy()
        .then(function(){
            return deployer.deploy(CallTelephone, Telephone.address, {from:accounts[0]});
        });
    }
};
