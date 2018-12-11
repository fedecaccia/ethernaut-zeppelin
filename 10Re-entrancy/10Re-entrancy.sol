pragma solidity ^0.4.18;

contract Reentrance {

    mapping(address => uint) public balances;

    function donate(address _to) public payable {
        balances[_to] += msg.value;
    }

    function balanceOf(address _who) public view returns (uint balance) {
        return balances[_who];
    }

    function withdraw(uint _amount) public {
        if(balances[msg.sender] >= _amount) {
            if(msg.sender.call.value(_amount)()) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }

    function() public payable {}
}

/*
If the msg.sender is a contract, it will call the fallback function.
The balance deduction is made after the call.
Therefore, if this code is called in the fallback function of the sender, it will cause a recursion, sending the value multiple times before reducing the sender's balance.

The DAO Hack
The famous DAO hack used reentrancy to extract a huge amount of ether from the victim contract.

MESSAGE

Use TRANSFER to move funds out of your contract, since it throws and limits gas forwarded.
Low level functions like call and send just return false but don't interrupt the execution flow when the receiving contract fails.
Always assume that the receiver of the funds you are sending can be another contract, not just a regular address.
Hence, it can execute code in its payable fallback method and re-enter your contract, possibly messing up your state/logic.
*/