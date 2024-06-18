// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher

pragma solidity ^0.8.25;

import "./Context.sol";

// Abstract contract to manage ownership of the contract.
abstract contract Ownable is Context {
    // Private variable to store the owner's address.
    address private _owner;

    // Event to log the transfer of ownership.
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // Constructor to set the deployer as the initial owner.
    constructor() {
        _transferOwnership(_msgSender());
    }

    // Function to get the address of the current owner.
    // @return address The address of the owner.
    function owner() public view virtual returns (address) {
        return _owner;
    }

    // Modifier to restrict access to owner-only functions.
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    // Function for the current owner to renounce ownership.
    // Transfers ownership to the zero address.
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    // Function to transfer ownership to a new address.
    // @param newOwner The address of the new owner.
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    // Internal function to handle ownership transfer.
    // @param newOwner The address of the new owner.
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}
