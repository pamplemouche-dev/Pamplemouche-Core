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
makefs -t cd9660 -o bootimage=i386\;/boot/cdboot -o no-emul-boot $OS_NAME.iso $WORK_DIR
