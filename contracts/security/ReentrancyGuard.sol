// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher

pragma solidity ^0.8.25;

// Abstract contract to prevent reentrant calls to a function.
abstract contract ReentrancyGuard {

    // Constants representing the status of the contract.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    // Variable to store the current status of the contract.
    uint256 private _status;

    // Constructor to initialize the contract status to _NOT_ENTERED.
    constructor() {
        _status = _NOT_ENTERED;
    }

    // Modifier to prevent reentrancy.
    modifier nonReentrant() {
        // Ensure the function is not already entered.
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");
        // Set the status to _ENTERED before executing the function.
        _status = _ENTERED;

        // Execute the function.
        _;

        // Set the status back to _NOT_ENTERED after executing the function.
        _status = _NOT_ENTERED;
    }
}
