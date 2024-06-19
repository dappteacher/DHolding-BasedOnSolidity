// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher

pragma solidity ^0.8.25;

// Define a library to manage roles in a permissioned system.
library Roles {
    // Define a Role struct that stores a mapping of addresses to boolean values.
    struct Role {
        mapping(address => bool) roleMembers;
    }

    // Function to add an account to a role.
    // @param role The Role struct storage pointer.
    // @param account The address to be added to the role.
    function add(Role storage role, address account) internal {
        // Ensure the account does not already have the role.
        require(!has(role, account), "Roles: account already has role");
        // Assign the role to the account.
        role.roleMembers[account] = true;
    }

    // Function to remove an account from a role.
    // @param role The Role struct storage pointer.
    // @param account The address to be removed from the role.
    function remove(Role storage role, address account) internal {
        // Ensure the account has the role.
        require(has(role, account), "Roles: account does not have role");
        // Remove the role from the account.
        role.roleMembers[account] = false;
    }

    // Function to check if an account has a role.
    // @param role The Role struct storage pointer.
    // @param account The address to check.
    // @return bool True if the account has the role, false otherwise.
    function has(Role storage role, address account) internal view returns (bool) {
        // Ensure the account is not the zero address.
        require(account != address(0), "Roles: account is the zero address");
        // Return whether the account has the role.
        return role.roleMembers[account];
    }
}
