// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArraysExercise {
    // Tableau de nombres initialisé avec les valeurs de 1 à 10
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    // Tableau pour stocker les adresses des expéditeurs
    address[] public senders;
    // Tableau pour stocker les timestamps
    uint[] public timestamps;

    // Fonction pour retourner le tableau complet
    function getNumbers() public view returns (uint[] memory) {
        return numbers; // Retourne le tableau des nombres
    }

    // Fonction pour réinitialiser le tableau des nombres
    function resetNumbers() public {
        numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]; // Réinitialise le tableau
    }

    // Fonction pour ajouter un tableau à l'existant
    function appendToNumbers(uint[] calldata _toAppend) public {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]); // Ajoute chaque élément du tableau à numbers
        }
    }

    // Fonction pour sauvegarder le timestamp
    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender); // Ajoute l'adresse de l'appelant
        timestamps.push(_unixTimestamp); // Ajoute le timestamp
    }

    // Fonction pour filtrer les timestamps après Y2K
    function afterY2K() public view returns (uint[] memory, address[] memory) {
        uint[] memory recentTimestamps = new uint[](timestamps.length);
        address[] memory recentSenders = new address[](timestamps.length);
        uint count = 0;

        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) { // Vérifie si le timestamp est après Y2K
                recentTimestamps[count] = timestamps[i];
                recentSenders[count] = senders[i];
                count++;
            }
        }

        // Crée des tableaux de taille appropriée
        uint[] memory filteredTimestamps = new uint[](count);
        address[] memory filteredSenders = new address[](count);

        for (uint j = 0; j < count; j++) {
            filteredTimestamps[j] = recentTimestamps[j];
            filteredSenders[j] = recentSenders[j];
        }

        return (filteredTimestamps, filteredSenders); // Retourne les tableaux filtrés
    }

    // Fonction pour réinitialiser les expéditeurs
    function resetSenders() public {
        delete senders; // Réinitialise le tableau des expéditeurs
    }

    // Fonction pour réinitialiser les timestamps
    function resetTimestamps() public {
        delete timestamps; // Réinitialise le tableau des timestamps
    }
}