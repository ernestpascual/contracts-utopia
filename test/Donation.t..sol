// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Donation} from "../src/Donation.sol";
import "forge-std/console2.sol";

contract DonationTest is Test {
    Donation public donation;

    address user;
    uint256 initalEtherBalance = 100 ether;

    function setUp() public {
        donation = new Donation();
        vm.deal(user, initalEtherBalance);
    }

    // test function
    function testReceiveDonation() public {
        uint256 etherToDonate = 1 ether;
        vm.startPrank(user);

        donation.receiveDonation{value: etherToDonate}();
        assertEq(initalEtherBalance - etherToDonate, user.balance);
        assertEq(donation.donationInfo(user), etherToDonate);
        assertEq(address(donation.donators(0)), user);

        vm.stopPrank();
    }
}
