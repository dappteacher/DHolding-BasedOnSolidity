// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher

pragma solidity ^0.8.25;

// Abstract contract to provide information about the current execution context.
abstract contract Context {
    // Function to get the address of the sender of the current call.
    // @return address The address of the sender.
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    // Function to get the calldata of the current call.
    // @return bytes The calldata of the current call.
    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}
