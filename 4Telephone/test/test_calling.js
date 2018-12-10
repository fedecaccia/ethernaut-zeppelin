var Telephone = artifacts.require("./Telephone.sol");
var CallTelephone = artifacts.require("./CallTelephone.sol");

var telephoneInstance;
var callTelephoneInstance;

var telephoneAdd;
var callTelephoneAdd;

contract('Testing', function(accounts) {
    it("should deploy Telephone", function() {
        return Telephone.deployed()
        .then(function(instance) {
            telephoneInstance = instance;
            return instance.address;
        })
        .then(function(add) {
            telephoneAdd = add;
            // console.log("Telephone deployed address: "+add);
            assert.notEqual(add, null, "The address is null");
        });
    });
    it("Telephone ownership is accounts[0]", function(){  
        return telephoneInstance.getOwner()
        .then(function(new_owner){
            assert.equal(new_owner, accounts[0])
        });
    });
    it("should deploy CallTelephone", function() {
        return CallTelephone.deployed()
        .then(function(instance) {
            callTelephoneInstance = instance;
            return instance.address;
        })
        .then(function(add) {
            callTelephoneAdd = add;
            // console.log("CallTelephone deployed address: "+add);
            assert.notEqual(add, null, "The address is null");
        });
    });
    it("should read telephone address from CallTelephone", function(){
        return callTelephoneInstance.getTelephoneAdd({from:accounts[0]})
        .then(function (add){
            // console.log("Telephone address on CallTelephone: "+add);
            assert.equal(add, telephoneAdd);
        });
    });
    it("should deploy a new CallTelephone", function(){
        return CallTelephone.new(telephoneAdd)
        .then(function (instance){
            assert.notEqual(instance.address, null);
        });
    });
    it("should change Telephone ownership to acounts[1]", function(){
        return callTelephoneInstance.calling(accounts[1], {from:accounts[1]})
        .then(function (add){            
            return telephoneInstance.getOwner()
        })
        .then(function(new_owner){
            assert.equal(new_owner, accounts[1])
        });
    });
});
