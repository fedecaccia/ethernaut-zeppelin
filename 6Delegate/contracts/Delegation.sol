pragma solidity ^0.4.18;

import "./Delegate.sol";

contract Delegation {

    address public owner;
    Delegate delegate;

    function Delegation(address _delegateAddress) public {
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    function() public {
        if(delegate.delegatecall(msg.data)) {
            this;
        }
    }
}

// Goal: claim Delegation's ownership

// The code at the target address is executed in the context of the calling contract
// and msg.sender and msg.value do not change their values.
// This means that a contract can dynamically load code from a different address at runtime.
// Storage, current address and balance still refer to the calling contract, only the code is taken from the called address.

// The difference between a normal call and delegatecall is that the latter passes the current context to the target method call,
// which means that in delegated method msg.sender will point to the original sender and not the caller contract.
// The second point is that this fallback function passes user supplied msg.data to delegatecall, allowing to basically call any function within delegate contract if we supply the correct method signature. The goal was to call the “pwn” method which could change the owner:

// function pwn() {
//   owner = msg.sender;
// }

// If we pass in the delegatecall function signature of pwn() in the message data, the pwn() function will execute,
// In order to call this function we needed to figure out its signature which could be calculated as follows:

// web3.utils-.sha3("pwn()").slice(0, 10) // 0xdd365b8b

// In versions < 1.0 you can call web3.sha3('xxx').
// In 1.0 it was moved to web3.utils.sha3

// Sending these 4 bytes in “data” field of the ether transfer transaction made us the owner and allowed to proceed to the next task.
// (1 byte : 2 hexa => 4 bytes : 8 hexa)