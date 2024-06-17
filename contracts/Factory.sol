// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher

pragma solidity 0.8.25;

import "./Agreement.sol";
import "./Role/Governable.sol";

// @title Factory Contract
// @dev This contract allows the deployment of new Agreement contracts and manages operators.
contract Factory is Governable {
    // @dev Event emitted when a new Agreement contract is created.
    // @param agreementAddress The address of the newly created Agreement contract.
    event AgreementCreated(address agreementAddress);

    // @notice Deploy a new Agreement contract.
    // @param name The name of the ERC20 token in the Agreement.
    // @param symbol The symbol of the ERC20 token in the Agreement.
    // @param initialSupply The initial supply of the ERC20 token in the Agreement.
    // @param quorum The quorum needed for the Agreement.
    // @param voters The list of voter addresses for the Agreement.
    // @param maxDelay The maximum delay for the Agreement.
    // @param minLockDuration The minimum lock duration for the Agreement.
    // @param stableCoinAddress The address of the stablecoin used in the Agreement.
    // @return The address of the newly created Agreement contract.
    function deployNewAgreement(
        string calldata name,
        string calldata symbol,
        uint256 initialSupply,
        uint256 quorum,
        address[] memory voters,
        uint256 maxDelay,
        uint256 minLockDuration,
        address stableCoinAddress
    ) public onlyOperator returns (address)  {
        Agreement t = new Agreement(
            name,
            symbol,
            initialSupply,
            msg.sender,
            quorum,
            voters,
            maxDelay,
            minLockDuration,
            stableCoinAddress
        );
        emit AgreementCreated(address(t));

        return address(t);
    }

    // @notice Add a new operator.
    // @param account The address of the operator to add.
    function addOperator (address account) public onlyOwner {
         _addOperator(account);
    }

    // @notice Remove an operator.
    // @param account The address of the operator to remove.
    function removeOperator (address account) public onlyOwner {
         _removeOperator(account);
    }
}
