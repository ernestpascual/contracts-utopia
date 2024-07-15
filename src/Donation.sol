// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Donation {
    // Stores the total donation amount
    uint256 public totalDonation;

    // Allow users track their individual contributions
    mapping(address => uint256) public donationInfo;

    // Front end helper to calculate top donators
    address[] public donators;

    event Donated(address indexed donator, uint256 indexed donation);

    // Implements a function to receive donations and update the total amount.
    function receiveDonation() external payable {
        // update first before doing external call to prevent reentrancy
        _storeDonator(msg.value, msg.sender);
        // update total donation
        totalDonation += msg.value;

        // emit event
        emit Donated(msg.sender, msg.value);
    }

    // stores donation information per donation
    function _storeDonator(uint256 _donationAmount, address _donator) private {
        // check if donator already donated to be calcualted through the leader boards
        if (donationInfo[_donator] == 0) {
            donators.push(msg.sender);
        }

        // add new donation amount
        donationInfo[_donator] += _donationAmount;
    }
}
