#!bin/bash
duration=10
# Lancer le script de compte à rebours en arrière-plan
if [ -f countdown.sh ]; then
    rm -f ./.countdown_expired
    ./countdown.sh $duration &
    echo "in progress" > ./.countdown_in_progress
else
    echo "Le script countdown.sh n'existe pas."
fi