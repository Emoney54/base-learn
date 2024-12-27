// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    // Struct to represent a contact
    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    // Mapping to store contacts by their ID
    mapping(uint => Contact) private contacts;
    uint private nextId; // To keep track of the next contact ID

    // Custom error for contact not found
    error ContactNotFound(uint id);

    // Constructor to set the initial owner
    constructor() Ownable(msg.sender) {
        // The owner is set to the address that deploys the contract
    }

    // Function to add a contact
    function addContact(string memory _firstName, string memory _lastName, uint[] memory _phoneNumbers) public onlyOwner {
        contacts[nextId] = Contact(nextId, _firstName, _lastName, _phoneNumbers);
        nextId++;
    }

    // Function to delete a contact
    function deleteContact(uint _id) public onlyOwner {
        if (contacts[_id].id == 0 && _id != 0) {
            revert ContactNotFound(_id);
        }
        delete contacts[_id];
    }

    // Function to get a contact
    function getContact(uint _id) public view returns (Contact memory) {
        if (contacts[_id].id == 0 && _id != 0) {
            revert ContactNotFound(_id);
        }
        return contacts[_id];
    }

    // Function to get all contacts
    function getAllContacts() public view returns (Contact[] memory) {
        Contact[] memory allContacts = new Contact[](nextId);
        for (uint i = 0; i < nextId; i++) {
            allContacts[i] = contacts[i];
        }
        return allContacts;
    }
}