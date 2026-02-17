#!/bin/sh
# Pamplemouche Core - ISO Builder
export OS_NAME="PamplemoucheCore"
export WORK_DIR="./build_out"

echo "--- Préparation de l'image Pamplemouche Core ---"
# 1. On nettoie et on crée le dossier de travail
rm -rf $WORK_DIR
mkdir -p $WORK_DIR

# 2. On copie tes configs personnalisées
# On s'assure que la structure est respectée
cp -R config/* $WORK_DIR/

echo "--- Création de l'ISO Bootable ---"
# 3. La commande magique qui va chercher le vrai chargeur de boot FreeBSD
# On utilise /boot/cdboot du système hôte
xorriso -as mkisofs -R -J \
  -b /boot/cdboot -no-emul-boot \
  -o $OS_NAME.iso $WORK_DIR
