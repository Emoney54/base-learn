// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./10.sol"; //changer par le nom de l'autre contract en .sol

contract AddressBookFactory {
    // Array to keep track of deployed AddressBooks
    AddressBook[] public addressBooks;

    // Function to deploy a new AddressBook
    function deploy() public returns (address) {
        AddressBook newAddressBook = new AddressBook(); // Create a new AddressBook instance
        addressBooks.push(newAddressBook); // Store the address of the new AddressBook
        return address(newAddressBook); // Return the address of the new AddressBook
    }

    // Function to get the number of deployed AddressBooks
    function getAddressBookCount() public view returns (uint) {
        return addressBooks.length; // Return the count of deployed AddressBooks
    }

    // Function to get the deployed AddressBook at a specific index
    function getAddressBook(uint index) public view returns (AddressBook) {
        require(index < addressBooks.length, "Index out of bounds"); // Ensure the index is valid
        return addressBooks[index]; // Return the AddressBook at the specified index
    }
}