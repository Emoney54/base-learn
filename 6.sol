// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GarageManager {

    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }

    // Mapping to store cars for each user
    mapping(address => Car[]) public garage;

    // Custom error for invalid car index
    error BadCarIndex(uint index);

    // Function to add a car to the user's garage
    function addCar(
        string memory _make, 
        string memory _model, 
        string memory _color, 
        uint _numberOfDoors
    ) public {
        // Create a new Car struct
        Car memory newCar = Car({
            make: _make,
            model: _model,
            color: _color,
            numberOfDoors: _numberOfDoors
        });

        // Add the car to the sender's garage
        garage[msg.sender].push(newCar);
    }

    // Function to get cars owned by the calling user
    function getMyCars() public view returns (Car[] memory) {
        return garage[msg.sender];
    }

    // Function to get cars for any given user
    function getUserCars(address _user) public view returns (Car[] memory) {
        return garage[_user];
    }

    // Function to update a specific car in the user's garage
    function updateCar(
        uint _index, 
        string memory _make, 
        string memory _model, 
        string memory _color, 
        uint _numberOfDoors
    ) public {
        // Check if the car index is valid
        if (_index >= garage[msg.sender].length) {
            revert BadCarIndex(_index);
        }

        // Update the car at the specified index
        garage[msg.sender][_index] = Car({
            make: _make,
            model: _model,
            color: _color,
            numberOfDoors: _numberOfDoors
        });
    }

    // Function to reset the user's entire garage
    function resetMyGarage() public {
        delete garage[msg.sender];
    }
}