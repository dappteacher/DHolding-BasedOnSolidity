// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher

pragma solidity ^0.8.25;

// Abstract contract to prevent reentrant calls to a function.
abstract contract ReentrancyGuard {

    // Constants representing the status of the contract.
    uint256 private constant STATUS_NOT_ENTERED = 1;
    uint256 private constant STATUS_ENTERED = 2;

    // Variable to store the current status of the contract.
    uint256 private reentrancyStatus;

    // Constructor to initialize the contract status to STATUS_NOT_ENTERED.
    constructor() {
        reentrancyStatus = STATUS_NOT_ENTERED;
    }

    // Modifier to prevent reentrancy.
    modifier nonReentrant() {
        // Ensure the function is not already entered.
        require(reentrancyStatus != STATUS_ENTERED, "ReentrancyGuard: reentrant call");
        // Set the status to STATUS_ENTERED before executing the function.
        reentrancyStatus = STATUS_ENTERED;

        // Execute the function.
        _;

        // Set the status back to STATUS_NOT_ENTERED after executing the function.
        reentrancyStatus = STATUS_NOT_ENTERED;
    }
}
