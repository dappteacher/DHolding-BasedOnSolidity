// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher

pragma solidity ^0.8.25;

import "../IERC20.sol";

// @title IERC20Metadata Interface
// @dev Interface for the ERC20 token with metadata.
interface IERC20Metadata is IERC20 {

    // @notice Get the name of the token.
    // @return The name of the token.
    function name() external view returns (string memory);

    // @notice Get the symbol of the token.
    // @return The symbol of the token.
    function symbol() external view returns (string memory);

    // @notice Get the number of decimals for the token.
    // @return The number of decimals for the token.
    function decimals() external view returns (uint8);
}
