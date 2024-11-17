#!/bin/bash

#vérifie que le joueur s'est caché à un seul endroit

# Initialiser un compteur pour les occurrences du nom du joueur 1
count=0
if [ -f /tmp/player1_name.txt ]; then
    player1_name=$(cat /tmp/player1_name.txt)
else
    echo "Erreur : le nom du joueur n'a pas été défini."
    exit 1
fi
if [ -f /tmp/player2_name.txt ]; then
    player2_name=$(cat /tmp/player2_name.txt)
else
    echo "Erreur : le nom du joueur n'a pas été défini."
    exit 1
fi

# Parcourir tous les fichiers .txt dans le répertoire courant
for file in $(find . -type f -name "*.txt"); do
    # Vérifier si le fichier existe (au cas où il n'y a pas de fichiers .txt)
    if [ -f "$file" ]; then
        # Compter les occurrences du nom du joueur 1 dans le fichier
        occurrences=$(grep -o "$player1_name" "$file" | wc -l)
        count=$((count + occurrences))

        if [ $occurrences -eq 1 ]; then 
            cachette=$file
            export cachette
            echo "$cachette" > /tmp/cachette.txt
        fi    
        # Ajouter au compteur global
        
    fi
done

# Vérifier si le nombre total d'occurrences est égal à 1
if [ $count -eq 1 ]; then #si le joueur est caché à un seul endroit
    echo "Tu es bien caché !"
    # Lancer le script de compte à rebours en arrière-plan
    duration=20
    if [ -f countdown.sh ]; then
        rm -f ./.countdown_expired
        ./countdown.sh $duration &
        echo "in progress" > ./.countdown_in_progress
    else
        echo "Le script countdown.sh n'existe pas."
    fi

    #demande de choisir le mot de passe
    while true; do
        # Demande de choisir le mot de passe
        read -s -p "Choisi un mot de passe pour verouiller ta cachette." mot_de_passe
        echo  # Nouvelle ligne après la saisie masquée

        # Demande de confirmer le mot de passe
        read -s -p "Confirmez votre mot de passe : " mot_de_passe_confirm
        echo  # Nouvelle ligne après la saisie masquée

        # Vérification des mots de passe
        if [[ "$mot_de_passe" == "$mot_de_passe_confirm" ]]; then
            echo "Mot de passe confirmé avec succès. Maintenant c'est le tour de $player2_name"
            
            #on cache le mot de passe dans un fichier aléatoire
            repertoire=$(pwd)
            fichiers=$(find "$repertoire" -type f -name "*.txt")
            fichier_choisi=$(echo "$fichiers" | shuf -n 1)
            echo "mot de passe : $mot_de_passe" >> "$fichier_choisi"
            echo "$mot_de_passe" > /tmp/mot_de_passe.txt
            break
        else
            echo "Les mots de passe ne correspondent pas. Veuillez réessayer."
        fi
    done

    #on donne les instruction au joueur 2
    echo "Bonjour, $player2_name ! Préparez-vous à jouer ! 🚀"
    echo "Un compte à rebourd de 20 minutes est lancé, vous pouvez le consulter dans time. Vous devez trouver la cachette de $player1_name. Une fois trouvée, lancez le script trouve"

else #si le joueur à écrit son prénom plusieurs fois ou 0 fois
    echo "Attention tu as écrit ton nom $count fois. Tu dois te cacher à un seul endroit."
fi

