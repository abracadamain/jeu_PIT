#!/bin/bash
player2_name=$(cat /tmp/player2_name.txt)
player1_name=$(cat /tmp/player1_name.txt)

# Vérifier si "temps écoulé" est écrit dans le fichier 'time'
if grep -q "temps écoulé" time; then
    echo "$player2_name vou avez perdu! $player1_name vous n'avez pas été trouvé bravo !"
    exit 0
fi

# Demander où est caché le joueur
echo "Où est caché le joueur ? (donnez le chemin relatif commençant par ./)"
read reponse

# Vérifier si la cachette est correcte
cachette=$(cat /tmp/cachette.txt)
if [[ "$reponse" == "$cachette" ]]; then
    echo "Vous avez trouvé $player1_name, mais la porte est verrouillée !"
    
    # Demander le mot de passe pour la porte
    while true; do
        echo "Quel est le mot de passe de la porte ?"
        read -s mot_de_passe  # Masque la saisie du mot de passe

        # Vérifier si le mot de passe est correct
        mot_de_passe_correct=$(cat /tmp/mot_de_passe.txt)
        if [[ "$mot_de_passe" == "$mot_de_passe_correct" ]]; then
            echo "Bravo $player2_name, vous avez gagné ! $player1_name vous avez été trouvé dommage."
            exit 0
        else
            echo "Mot de passe incorrect, réessayez. (Indice, le mot de passe est indiqué par 'mot de passe : ' dans un fichier texte)"
        fi
    done
else
    echo "Désolé, ce n'est pas la bonne cachette."
fi
