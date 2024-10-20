#!/bin/bash

LOGFILE="$HOME/Scripts/UpdateSystem_$(date +'%d-%m-%Y').log"

echo "Sto aggiornando..."
{
    echo "Iniziato alle: $(date +'%H:%M:%S')"
    echo "------------------------"
    sudo dnf update -y
    sudo dnf autoremove -y
    flatpak update -y
    flatpak uninstall --unused -y
    echo "--------------------------"
    echo "Completato alle: $(date +'%H:%M:%S')"
} &> "$LOGFILE"
echo "Fatto! Loggato!"
