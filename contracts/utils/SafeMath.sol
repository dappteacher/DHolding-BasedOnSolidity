// SPDX-License-Identifier: MIT
// Author: Yaghoub Adelzadeh
// GitHub: https://www.github.com/dappteacher

pragma solidity ^0.8.25;

// Library for safe mathematical operations.
library SafeMath {
    
    // Function to safely add two unsigned integers, with an overflow flag.
    // @param a The first operand.
    // @param b The second operand.
    // @return (bool, uint256) Whether the addition was successful, and the result.
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    // Function to safely subtract one unsigned integer from another, with an overflow flag.
    // @param a The first operand.
    // @param b The second operand.
    // @return (bool, uint256) Whether the subtraction was successful, and the result.
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    // Function to safely multiply two unsigned integers, with an overflow flag.
    // @param a The first operand.
    // @param b The second operand.
    // @return (bool, uint256) Whether the multiplication was successful, and the result.
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    // Function to safely divide two unsigned integers, with a division by zero flag.
    // @param a The first operand.
    // @param b The second operand.
    // @return (bool, uint256) Whether the division was successful, and the result.
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    // Function to safely compute the modulo of two unsigned integers, with a division by zero flag.
    // @param a The first operand.
    // @param b The second operand.
    // @return (bool, uint256) Whether the modulo operation was successful, and the result.
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    // Function to safely add two unsigned integers.
    // @param a The first operand.
    // @param b The second operand.
    // @return uint256 The result of the addition.
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    // Function to safely subtract one unsigned integer from another.
    // @param a The first operand.
    // @param b The second operand.
    // @return uint256 The result of the subtraction.
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    // Function to safely multiply two unsigned integers.
    // @param a The first operand.
    // @param b The second operand.
    // @return uint256 The result of the multiplication.
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    // Function to safely divide two unsigned integers.
    // @param a The first operand.
    // @param b The second operand.
    // @return uint256 The result of the division.
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    // Function to safely compute the modulo of two unsigned integers.
    // @param a The first operand.
    // @param b The second operand.
    // @return uint256 The result of the modulo operation.
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    // Function to safely subtract one unsigned integer from another, with a custom error message.
    // @param a The first operand.
    // @param b The second operand.
    // @param errorMessage The custom error message.
    // @return uint256 The result of the subtraction.
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    // Function to safely divide two unsigned integers, with a custom error message.
    // @param a The first operand.
    // @param b The second operand.
    // @param errorMessage The custom error message.
    // @return uint256 The result of the division.
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    // Function to safely compute the modulo of two unsigned integers, with a custom error message.
    // @param a The first operand.
    // @param b The second operand.
    // @param errorMessage The custom error message.
    // @return uint256 The result of the modulo operation.
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}
