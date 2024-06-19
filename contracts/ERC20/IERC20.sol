// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher

pragma solidity ^0.8.25;

interface IERC20 {

    // @notice Emitted when `value` tokens are moved from one account (`from`) to another (`to`)
    // @param from The address of the sender
    // @param to The address of the receiver
    // @param value The amount of tokens transferred
    event Transfer(address indexed from, address indexed to, uint256 value);

    // @notice Emitted when the allowance of a `spender` for an `owner` is set by a call to `approve`
    // @param owner The address of the token owner
    // @param spender The address of the spender
    // @param value The new allowance amount
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // @notice Returns the amount of tokens in existence
    // @return The total supply of tokens
    function totalSupply() external view returns (uint256);

    // @notice Returns the amount of tokens owned by `account`
    // @param account The address to query the balance of
    // @return The balance of the account
    function balanceOf(address account) external view returns (uint256);

    // @notice Moves `amount` tokens from the caller's account to `to`
    // @param to The address of the recipient
    // @param amount The amount of tokens to be transferred
    // @return A boolean value indicating whether the operation succeeded
    function transfer(address to, uint256 amount) external returns (bool);

    // @notice Returns the remaining number of tokens that `spender` will be allowed to spend on behalf of `owner` through `transferFrom`
    // @param owner The address of the token owner
    // @param spender The address of the spender
    // @return The remaining allowance for the spender
    function allowance(address owner, address spender) external view returns (uint256);

    // @notice Sets `amount` as the allowance of `spender` over the caller's tokens
    // @param spender The address of the spender
    // @param amount The amount of tokens to be approved
    // @return A boolean value indicating whether the operation succeeded
    function approve(address spender, uint256 amount) external returns (bool);

    // @notice Moves `amount` tokens from `from` to `to` using the allowance mechanism
    // @param from The address of the sender
    // @param to The address of the recipient
    // @param amount The amount of tokens to be transferred
    // @return A boolean value indicating whether the operation succeeded
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}
