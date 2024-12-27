// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnburnableToken {
    // Stockage des données
    mapping(address => uint256) public balances; // Mapping des soldes des utilisateurs
    uint256 public totalSupply; // Total des tokens
    uint256 public totalClaimed; // Total des tokens réclamés
    mapping(address => bool) private hasClaimed; // Suivi des réclamations par adresse

    // Définition des erreurs
    error TokensClaimed(); // Si une adresse a déjà réclamé
    error AllTokensClaimed(); // Si tous les tokens ont été distribués
    error UnsafeTransfer(address); // Si les conditions de transfert ne sont pas respectées

    // Constructeur : initialise totalSupply à 100,000,000
    constructor() {
        totalSupply = 100_000_000; // 100 millions de tokens
    }

    // Fonction publique pour réclamer des tokens
    function claim() public {
        if (totalClaimed >= totalSupply) {
            revert AllTokensClaimed(); // Tous les tokens sont distribués
        }
        if (hasClaimed[msg.sender]) {
            revert TokensClaimed(); // Adresse a déjà réclamé
        }
        balances[msg.sender] += 1000; // Ajoute 1000 tokens au solde
        totalClaimed += 1000; // Met à jour le total réclamé
        hasClaimed[msg.sender] = true; // Marque l'adresse comme ayant réclamé
    }

    // Fonction publique pour un transfert sécurisé
   function safeTransfer(address _to, uint256 _amount) public {
    // Vérifie si l'adresse destinataire est valide (pas 0x0)
    if (_to == address(0)) {
        revert UnsafeTransfer(_to);
    }
    // Vérifie si l'adresse destinataire a un solde ETH > 0
    if (_to.balance == 0) {
        revert UnsafeTransfer(_to);
    }
    // Vérifie si l'expéditeur a un solde suffisant
    require(balances[msg.sender] >= _amount, "Insufficient balance");
    // Effectue le transfert
    balances[msg.sender] -= _amount;
    balances[_to] += _amount;
}


}
