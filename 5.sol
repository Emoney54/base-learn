// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FavoriteRecords {
    // Mapping to track approved records
    mapping(string => bool) public approvedRecords;

    // Nested mapping to track user favorites
    mapping(address => mapping(string => bool)) public userFavorites;

    // Custom error for unapproved records
    error NotApproved(string albumName);

    // Array to store approved record names for retrieval
    string[] private approvedRecordNames;

    // Constructor to initialize approved records
    constructor() {
        string[9] memory albums = [
            "Thriller",
            "Back in Black", 
            "The Bodyguard",
            "The Dark Side of the Moon",
            "Their Greatest Hits (1971-1975)",
            "Hotel California",
            "Come On Over",
            "Rumours", 
            "Saturday Night Fever"
        ];

        // Load approved records
        for (uint i = 0; i < albums.length; i++) {
            approvedRecords[albums[i]] = true;
            approvedRecordNames.push(albums[i]);
        }
    }

    // Function to get all approved records
    function getApprovedRecords() public view returns (string[] memory) {
        return approvedRecordNames;
    }
// Function to add a record to user's favorites
    function addRecord(string memory _albumName) public {
        // Check if the record is approved
        if (!approvedRecords[_albumName]) {
            revert NotApproved(_albumName);
        }

        // Add to user's favorites
        userFavorites[msg.sender][_albumName] = true;
    }

    // Function to get user's favorite records
    function getUserFavorites(address _user) public view returns (string[] memory) {
        // Create a dynamic array to store favorites
        string[] memory favorites = new string[](approvedRecordNames.length);
        uint count = 0;

        // Iterate through approved records to find user's favorites
        for (uint i = 0; i < approvedRecordNames.length; i++) {
            if (userFavorites[_user][approvedRecordNames[i]]) {
                favorites[count] = approvedRecordNames[i];
                count++;
            }
        }

        // Resize the array to remove empty slots
        string[] memory userFavoritesList = new string[](count);
        for (uint i = 0; i < count; i++) {
            userFavoritesList[i] = favorites[i];
        }

        return userFavoritesList;
    }

    // Function to reset user's favorites
    function resetUserFavorites() public {
        // Iterate through approved records to reset user's favorites
        for (uint i = 0; i < approvedRecordNames.length; i++) {
            userFavorites[msg.sender][approvedRecordNames[i]] = false;
        }
    }
}