// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher

pragma solidity 0.8.25;

import "./utils/SafeMath.sol";
import "./utils/Ownable.sol";
import "./ERC20Token.sol";
import "./Role/Governable.sol";
import "./security/ReentrancyGuard.sol";

// @title Agreement Contract
// @dev This contract handles the creation of an ERC20 token, voting mechanism, and profit distribution.
contract Agreement is Governable, ReentrancyGuard {
    using SafeMath for uint256;

    // @notice Emitted when a new token is created.
    event TokenCreated(address tokenAddress);

    // @notice Emitted when a vote is cast.
    event VoteCasted(address voter);

    // @notice Emitted when the tokens are unlocked.
    event Unlocked();

    // @notice Emitted when the profit rate is changed.
    event ProfitRateChanged(uint256 newRate);

    // @notice Emitted when the deadline is changed.
    event DeadlineChanged(uint256 newDeadline);

    ERC20Token public token; // The ERC20 token created by the contract
    IERC20 public stableCoin; // The stablecoin used for profit distribution
    uint256 public quorum; // The minimum number of votes required to unlock tokens
    uint256 public votes; // The current number of votes cast
    uint256 public deadline; // The deadline by which profit must be received
    uint256 public maxDelay; // The maximum delay allowed for voting
    uint256 public votingStartDate; // The start date of the voting period
    uint256 public profitRate = 1000000; // The profit rate (multiplied by 1,000,000)
    bool public locked = true; // Indicates if the tokens are locked
    mapping(address => bool) public hasVoted; // Tracks which addresses have voted

    // @notice Constructor to initialize the Agreement contract.
    // @param name The name of the ERC20 token.
    // @param symbol The symbol of the ERC20 token.
    // @param initialSupply The initial supply of the ERC20 token.
    // @param deployer The address deploying the contract.
    // @param _quorum The number of votes required to unlock tokens.
    // @param _operators The list of operator addresses.
    // @param _maxDelay The maximum delay allowed for voting.
    // @param _minLockDuration The minimum duration for locking the tokens.
    // @param _stableCoin The address of the stablecoin contract.
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply,
        address deployer,
        uint256 _quorum,
        address[] memory _operators,
        uint256 _maxDelay,
        uint256 _minLockDuration,
        address _stableCoin
    ) {
        require(_quorum > 0, "Agreement: number of needed witnesses must be greater than zero");
        require(_quorum <= _operators.length, "Agreement: quorum must be less than or equal to number of operators");

        token = new ERC20Token(
            name,
            symbol,
            18,
            initialSupply,
            deployer
        );

        stableCoin = IERC20(address(_stableCoin));
        quorum = _quorum;
        maxDelay = _maxDelay;
        for (uint i = 0; i < _operators.length; i++) {
            _addOperator(_operators[i]);
        }

        votingStartDate = block.timestamp.add(_minLockDuration.mul(1 days));

        transferOwnership(deployer);
        emit TokenCreated(address(token));
    }

    // @notice Cast a vote to unlock the tokens.
    // @dev Only callable by an operator.
    function castVote() public onlyOperator {
        require(hasVoted[msg.sender] == false, "Agreement: already voted");
        require(locked == true, "Agreement: tokens are already unlocked");
        require(block.timestamp >= votingStartDate, "Agreement: voting is not started yet");

        emit VoteCasted(msg.sender);
        hasVoted[msg.sender] = true;
        votes++;

        if (votes >= quorum) {
            locked = false;
            deadline = block.timestamp.add(maxDelay.mul(1 days));
            emit Unlocked();
        }
    }

    // @notice Receive profit in stablecoins by exchanging ERC20 tokens.
    // @param _to The address to send the stablecoins to.
    // @dev This function is protected against reentrancy attacks.
    function receiveProfit(address _to) public nonReentrant {
        require(locked == false, "Agreement: project is not finished yet");
        require(block.timestamp <= deadline, "Agreement: project deadline is passed");

        uint256 balance = token.balanceOf(msg.sender);
        token.transferFrom(msg.sender, address(this), balance);
        stableCoin.transfer(_to, balance.mul(profitRate).div(1000000));
    }

    // @notice Set a new profit rate.
    // @param rate The new profit rate (must be at least 1,000,000).
    // @dev Only callable by the contract owner.
    function setProfitRate(uint256 rate) public onlyOwner {
        require(rate >= 1000000, "Agreement: rate / 1000000 must be at least equal to one");
        profitRate = rate;
        emit ProfitRateChanged(rate);
    }

    // @notice Increase the deadline for receiving profits.
    // @param delayTimeInDays The number of days to add to the deadline.
    // @dev Only callable by the contract owner.
    function increaseDeadline(uint256 delayTimeInDays) public onlyOwner {
        require(locked == false, "Agreement: project is not finished yet");
        deadline = deadline.add(delayTimeInDays.mul(1 days));
        emit DeadlineChanged(deadline);
    }

    // @notice Discharge remaining stablecoins to a specified address after the deadline has passed.
    // @param _to The address to send the remaining stablecoins to.
    // @dev Only callable by the contract owner.
    function discharge(address _to) public onlyOwner {
        require(locked == false, "Agreement: project is not finished yet");
        require(block.timestamp > deadline, "Agreement: project deadline is not passed yet");
        uint256 balance = stableCoin.balanceOf(address(this));
        stableCoin.transfer(_to, balance);
    }
}
```
