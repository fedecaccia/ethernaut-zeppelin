var Delegate = artifacts.require("./Delegate.sol");
var Delegation = artifacts.require("./Delegation.sol");

var delegateInstance;

contract('Deployment', function(accounts) {
    it("should deploy Delegate", function() {
        return Delegate.deployed()
        .then(function(instance) {
            delegateInstance = instance;
            return instance.address;
        })
        .then(function(add) {
            assert.notEqual(add, null, "The address is null");
        });
    });
    it("should deploy Delegation", function() {
        return Delegation.deployed()
        .then(function(instance) {
            return instance.address;
        })
        .then(function(add) {
            assert.notEqual(add, null, "The address is null");
        });
    });
    it("should print Delegate owner", function() {
        return delegateInstance.getOwner()
        .then(function(owner) {
            assert.equal(owner, accounts[0]);
        })
    });
    it("should change ownership", function() {
        return delegateInstance.pwn({from:accounts[2]})
        .then(function() {
            return delegateInstance.getOwner();
        })
        .then(function(owner) {
            assert.equal(owner, accounts[2]);
        });
    });
});