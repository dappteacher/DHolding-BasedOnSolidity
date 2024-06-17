// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher

pragma solidity ^0.8.25;

import "./IERC20.sol";
import "./extensions/IERC20Metadata.sol";
import "../utils/Context.sol";

// @title ERC20 Token Implementation
// @dev Implementation of the IERC20 and IERC20Metadata interfaces.
contract ERC20 is Context, IERC20, IERC20Metadata {
    // Mapping from account addresses to their balances
    mapping(address => uint256) private _balances;

    // Mapping from account addresses to allowances
    mapping(address => mapping(address => uint256)) private _allowances;

    // Total supply of tokens
    uint256 private _totalSupply;

    // Token name
    string private _name;
    
    // Token symbol
    string private _symbol;

    // @dev Sets the values for {name} and {symbol}.
    // All two of these values are immutable: they can only be set once during construction.
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    // @notice Returns the name of the token.
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    // @notice Returns the symbol of the token.
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    // @notice Returns the number of decimals used to get its user representation.
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    // @notice See {IERC20-totalSupply}.
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    // @notice See {IERC20-balanceOf}.
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    // @notice See {IERC20-transfer}.
    // @dev Moves `amount` tokens from the caller's account to `to`.
    // Returns a boolean value indicating whether the operation succeeded.
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    // @notice See {IERC20-allowance}.
    // @dev Returns the remaining number of tokens that `spender` will be allowed to spend on behalf of `owner` through {transferFrom}.
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    // @notice See {IERC20-approve}.
    // @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
    // Returns a boolean value indicating whether the operation succeeded.
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    // @notice See {IERC20-transferFrom}.
    // @dev Moves `amount` tokens from `from` to `to` using the allowance mechanism.
    // `amount` is then deducted from the caller's allowance.
    // Returns a boolean value indicating whether the operation succeeded.
    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    // @notice Atomically increases the allowance granted to `spender` by the caller.
    // @dev Increases the allowance by `addedValue`.
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    // @notice Atomically decreases the allowance granted to `spender` by the caller.
    // @dev Decreases the allowance by `subtractedValue`.
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    // @notice Moves `amount` of tokens from `from` to `to`.
    // @dev Internal function that can be used to implement custom transfer logic.
    function _transfer(address from, address to, uint256 amount) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
        }
        _balances[to] += amount;

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    // @notice Creates `amount` tokens and assigns them to `account`, increasing the total supply.
    // @dev Internal function that can be used to implement custom minting logic.
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    // @notice Destroys `amount` tokens from `account`, reducing the total supply.
    // @dev Internal function that can be used to implement custom burning logic.
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    // @notice Sets `amount` as the allowance of `spender` over the `owner` s tokens.
    // @dev Internal function that can be used to implement custom approval logic.
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    // @notice Updates `owner` s allowance for `spender` based on spent `amount`.
    // @dev Internal function that can be used to implement custom allowance spending logic.
    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    // @notice Hook that is called before any transfer of tokens.
    // @dev Can be used to implement custom transfer logic.
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {}

    // @notice Hook that is called after any transfer of tokens.
    // @dev Can be used to implement custom transfer logic.
    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {}
}
