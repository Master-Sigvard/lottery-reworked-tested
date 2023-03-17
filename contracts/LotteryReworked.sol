// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

abstract contract RandomNumbers is VRFConsumerBaseV2 {
    
}

/// @title Lottery
contract Lottery is Ownable{
    ///@dev array with addresses of all players
    address payable[] public players;
    uint tickets = 4;
    ///@notice cost of tickets
    uint cost = 100 wei;
    uint i;


    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }

    ///@dev use chainlink for random numbers
    function random(uint _number) public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender))) % _number;
    }

    function enterLottery() public payable {
        require(msg.value == cost && tickets > 0);
        tickets--;
        ///@dev adding new player to players array
        players.push(payable(msg.sender));
    }

    function chooseWinner() external onlyOwner {
                
    }
}