#!/bin/bash

# Définir les règles du jeu
display_rules() {
    echo "========== RÈGLES DU JEU =========="
    echo "$player1_name commence, $player2_name ne doit pas regarder l'écran pour l'instant."
    echo "$player1_name, en tant que cacheur, vous devez cacher votre nom proprement dans un lieu (fichier texte). Une fois bien caché, lancez le script je_suis_cache."
    echo "Amusez-vous bien ! 🎉"  
}

# Demander le nom du joueur 1
get_player_name1() {
    echo -n "Joueur 1, entrez votre nom : "
    read player1_name
    if [[ -z "$player1_name" ]]; then
        echo "Veuillez entrer un nom valide."
        get_player_name1
    fi
    export player1_name
    echo "$player1_name" > /tmp/player1_name.txt
}

# Demander le nom du joueur 2
get_player_name2() {
    echo -n "Joueur 2, entrez votre nom : "
    read player2_name
    if [[ -z "$player2_name" ]]; then
        echo "Veuillez entrer un nom valide."
        get_player_name2
    fi
    export player2_name
    echo "$player2_name" > /tmp/player2_name.txt
}

# Démarrage du script
start_game() {
    echo "Bienvenue dans le jeu cache-cache ! 2 joueurs sont requis."
    get_player_name1
    get_player_name2
    display_rules
}


# Lancer le jeu
start_game