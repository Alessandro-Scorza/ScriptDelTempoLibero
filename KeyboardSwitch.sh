#!/bin/bash

# ID della tastiera esterna
KEYBOARD_ID="1234:abcd"

# Intervallo di controllo in secondi
INTERVAL=5

# Stato precedente della tastiera (0 = scollegata, 1 = collegata)
PREVIOUS_STATE=0

while true; do
    # Controlla se la tastiera esterna è collegata
    if lsusb | grep -q "$KEYBOARD_ID"; then
        # Imposta il layout della tastiera su inglese
        gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"
        # Notifica di connessione solo se lo stato è cambiato
        if [ $PREVIOUS_STATE -eq 0 ]; then
            notify-send -t 3000 "Tastiera USB" "Tastiera connessa! Layout su inglese."
            PREVIOUS_STATE=1
        fi
    else
        # Imposta il layout della tastiera su italiano
        gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'it')]"
        # Notifica di disconnessione solo se lo stato è cambiato
        if [ $PREVIOUS_STATE -eq 1 ]; then
            notify-send -t 3000 "Tastiera USB" "Tastiera scollegata. Layout in italiano."
            PREVIOUS_STATE=0
        fi
    fi
    # Aspetta x secondi prima di rifare il check
    sleep $INTERVAL
done
