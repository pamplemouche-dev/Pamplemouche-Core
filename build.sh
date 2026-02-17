#!/bin/sh
# Pamplemouche Core - ISO Builder
export OS_NAME="PamplemoucheCore"
export WORK_DIR="./build_out"

echo "--- Préparation de l'image Pamplemouche Core ---"
mkdir -p $WORK_DIR

# Copie des configurations vers le futur système
cp -R config/* $WORK_DIR/

# Commande de création de l'ISO bootable
# (Simulée pour l'exemple, à adapter selon l'outil de build choisi)
# Version corrigée pour rendre l'ISO bootable
xorriso -as mkisofs -R -J -b boot/cdboot -no-emul-boot -o PamplemoucheCore.iso ./build_out
