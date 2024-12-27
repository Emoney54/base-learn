// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeStorage {
    // Custom error for granting too many shares
    error TooManyShares(uint currentShares);

    // State variables optimized for storage packing
    uint16 private shares;   // Nombre d'actions de l'employé
    uint32 private salary;    // Salaire de l'employé
    uint256 public idNumber;  // ID de l'employé
    string public name;       // Nom de l'employé

    // Constructor to set initial values
    constructor() {
        shares = 1000; // Initialisation des actions
        name = "Pat";  // Initialisation du nom
        salary = 50000; // Initialisation du salaire
        idNumber = 112358132134; // Initialisation de l'ID
    }

    // Function to view salary
    function viewSalary() public view returns (uint32) {
        return salary; // Retourne le salaire
    }

    // Function to view shares
    function viewShares() public view returns (uint16) {
        return shares; // Retourne le nombre d'actions
    }

    // Function to grant shares with conditions
    function grantShares(uint16 _newShares) public {
        // First, check if a single grant exceeds 5000
        if (_newShares > 5000) {
            revert("Too many shares"); // Revert if trying to grant more than 5000 shares
        }

        // Then check if total shares would exceed 5000
        if (shares + _newShares > 5000) {
            revert TooManyShares(shares + _newShares); // Revert with custom error if total exceeds 5000
        }

        // Grant shares
        shares += _newShares; // Ajoute les nouvelles actions
    }

    // Function to check storage packing
    // Used for unit testing storage optimization
    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot) // Lit la valeur à l'emplacement de stockage spécifié
        }
    }

    // Debug function to reset shares
    // Warning: Publicly accessible
    function debugResetShares() public {
        shares = 1000; // Réinitialise le nombre d'actions à 1000
    }
}