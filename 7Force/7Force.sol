pragma solidity ^0.4.18;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}

/*
We need a way to send ether to this contract, but there is no payable function.

Not to worry, selfdestruct is at hand. The selfdestruct method allows a contract to delete itself, and send any funds it may have before doing so.

pragma solidity ^0.4.18;

contract Thing {
    function sendToForce(address force) public payable {
        selfdestruct(force);
    }
}
*/