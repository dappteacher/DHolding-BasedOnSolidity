// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher

pragma solidity ^0.8.25;

// Import the Context contract to provide information about the current execution context.
import "../utils/Context.sol";

// Import the Ownable contract to provide basic authorization control functions.
import "../utils/Ownable.sol";

// Import the Roles library to manage the assignment and removal of roles.
import "./Roles.sol";

// Define the Governable contract, inheriting from Context and Ownable.
contract Governable is Context, Ownable {
    // Use the Roles library for the Roles.Role struct.
    using Roles for Roles.Role;

    // Event emitted when an operator is added.
    event OperatorAdded(address indexed account);
    
    // Event emitted when an operator is removed.
    event OperatorRemoved(address indexed account);

    // Declare a private Role struct to store operator addresses.
    Roles.Role private _operators;

    // Constructor to initialize the contract and add the deployer as an operator if not already.
    constructor() {
        if (!isOperator(_msgSender())) {
            _addOperator(_msgSender());
        }
    }

    // Modifier to restrict function access to operators only.
    modifier onlyOperator() {
        require(
            isOperator(_msgSender()),
            "OperatorRole: caller does not have the Operator role"
        );
        _;
    }

    // Function to check if an account is an operator.
    // @param account The address to check.
    // @return bool True if the account is an operator, false otherwise.
    function isOperator(address account) public view returns (bool) {
        return _operators.has(account);
    }

    // Internal function to add an account as an operator.
    // @param account The address to add as an operator.
    function _addOperator(address account) internal {
        _operators.add(account);
        emit OperatorAdded(account);
    }

    // Internal function to remove an account from operators.
    // @param account The address to remove from operators.
    function _removeOperator(address account) internal {
        _operators.remove(account);
        emit OperatorRemoved(account);
    }
}
