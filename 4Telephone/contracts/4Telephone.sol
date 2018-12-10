pragma solidity ^0.4.18;

contract Telephone {

    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}

// tx.origin: the initial caller of a chain of transactions
// msg.sender: the caller in the last link in the chain
// We should call the changeOwner function from a contract, so:
// msg.sender: caller_contract address
// tx.origin: the address from where aI call the caller_contract