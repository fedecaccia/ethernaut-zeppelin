pragma solidity ^0.4.18;

// contract Telephone {
//     function changeOwner(address _owner) public;
// }
import "./4Telephone.sol";

contract CallTelephone {

    address public TelephoneContractAddress;

    constructor (address add) public {
        TelephoneContractAddress = add;
    }

    function calling(address new_owner) public {

        Telephone tl = Telephone(TelephoneContractAddress);
        tl.changeOwner(new_owner);
    }

    function getTelephoneAdd() public view returns (address) {

        return TelephoneContractAddress;
    }
}