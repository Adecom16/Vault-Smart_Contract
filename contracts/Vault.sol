// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
    address public owner;
    uint public unlockTime;
    address public beneficiary;
    uint public amount;

    constructor(address _beneficiary, uint _unlockTime) payable {
        owner = msg.sender;
        beneficiary = _beneficiary;
        unlockTime = _unlockTime;
        amount = msg.value;
    }

    function claim() public {
        require(msg.sender == beneficiary, "Only the beneficiary can claim the funds");
        require(block.timestamp >= unlockTime, "Funds are not yet available to claim");
        payable(beneficiary).transfer(address(this).balance);
    }

    function deposit() public payable {
        require(msg.sender == owner, "Only the owner can deposit funds");
        amount += msg.value;
    } 

    function changeBeneficiary(address _newBeneficiary) public {
        require(msg.sender == owner, "Only the owner can change the beneficiary");
        beneficiary = _newBeneficiary;
    }

    function changeUnlockTime(uint _newUnlockTime) public {
        require(msg.sender == owner, "Only the owner can change the unlock time");
        unlockTime = _newUnlockTime;
    }

    function withdraw() public {
        require(msg.sender == owner, "Only the owner can withdraw remaining funds");
        require(block.timestamp >= unlockTime, "Funds are not yet available to withdraw");
        payable(owner).transfer(address(this).balance);
    }
}
