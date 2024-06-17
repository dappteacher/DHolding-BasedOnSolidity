// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher
pragma solidity >=0.8.25;

import "./ERC20/ERC20.sol";

// @title ERC20Token Contract
// @dev This contract implements an ERC20 token with an initial supply, name, symbol, and owner.
contract ERC20Token is ERC20 {
    
    // @notice Constructor to initialize the ERC20 token with the given parameters.
    // @param name The name of the ERC20 token.
    // @param symbol The symbol of the ERC20 token.
    // @param decimals The number of decimals the token uses.
    // @param initialSupply The initial supply of the token.
    // @param owner The address that receives the initial supply of tokens.
    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals,
        uint256 initialSupply,
        address owner
    ) ERC20(name, symbol) {
        // Mint the initial supply to the owner's address
        _mint(owner, initialSupply * 10**uint256(decimals));
    }
}
