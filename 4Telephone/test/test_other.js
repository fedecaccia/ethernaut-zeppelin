var Telephone = artifacts.require("./Telephone.sol");
var CallTelephone = artifacts.require("./CallTelephone.sol");

var should = require('should');

contract('Testing', function(accounts) {
    beforeEach('setup contract for each test', async function () {
        telephoneInstance = await Telephone.new()
    });

    it("should deploy a new CallTelephone", function(){
        return CallTelephone.new(telephoneInstance.address)
        .then(function (instance){
            assert.notEqual(instance.address, null);
        });
    });

    it("should not deploy a new CallTelephone with bad argument", function(done){
        try{
            CallTelephone.new("telephoneInstance.address");
            should.fail("No error was thrown when it should have been")
        }
        catch (error){
            done();
        }
    });
   
    it("should not deploy a new CallTelephone with none argument", function(done){
        try{
            CallTelephone.new();
            should.fail("No error was thrown when it should have been")
        }
        catch (error){
            done();
        }
    });

});