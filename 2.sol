// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ControlStructures {
    // Custom error for the doNotDisturb function
    error AfterHours(uint time);

    // FizzBuzz function implementation
    function fizzBuzz(uint _number) public pure returns (string memory) {
        // Check divisibility by both 3 and 5 first
        if (_number % 3 == 0 && _number % 5 == 0) {
            return "FizzBuzz";
        }
        // Check divisibility by 3
        if (_number % 3 == 0) {
            return "Fizz";
        }
        // Check divisibility by 5
        if (_number % 5 == 0) {
            return "Buzz";
        }
        // If no conditions are met
        return "Splat";
    }

    // Do Not Disturb function implementation
    function doNotDisturb(uint _time) public pure returns (string memory) {
        // Check for invalid time (>= 2400)
        if (_time >= 2400) {
            // Trigger panic (will cause the transaction to revert with a panic error)
            assert(false);
        }

        // Check for after hours (before 8:00 or after 22:00)
        if (_time > 2200 || _time < 800) {
            revert AfterHours(_time);
        }

        // Check for lunch time
        if (_time >= 1200 && _time <= 1259) {
            revert("At lunch!");
        }

        // Check morning hours
        if (_time >= 800 && _time <= 1199) {
            return "Morning!";
        }

        // Check afternoon hours
        if (_time >= 1300 && _time <= 1799) {
            return "Afternoon!";
        }

        // Check evening hours
        if (_time >= 1800 && _time <= 2200) {
            return "Evening!";
        }

        // Fallback (though this should never be reached with the above conditions)
        return "";
    }
}