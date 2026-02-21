#!/bin/sh
# Pamplemouche Core - ISO Builder avec téléchargement de la base
export OS_NAME="PamplemoucheCore"
export WORK_DIR="./build_out"
# On choisit la version 14.0 pour la stabilité sur iPad
export RELEASE="14.0-RELEASE"

echo "--- Nettoyage et préparation ---"
rm -rf $WORK_DIR
mkdir -p $WORK_DIR

echo "--- Téléchargement de la base FreeBSD (environ 150Mo) ---"
# On télécharge les composants essentiels
fetch https://download.freebsd.org/releases/amd64/$RELEASE/base.txz
fetch https://download.freebsd.org/releases/amd64/$RELEASE/kernel.txz

echo "--- Extraction du système ---"
# On décompresse tout dans ton dossier de build
tar -xf base.txz -C $WORK_DIR
tar -xf kernel.txz -C $WORK_DIR

echo "--- Injection de la configuration Pamplemouche ---"
# On ajoute tes réglages (le logo, le dock, etc.)
cp -R config/* $WORK_DIR/

echo "--- Création de l'ISO finale ---"
# On s'assure que le bootloader est bien copié depuis la base qu'on vient d'extraire
cp $WORK_DIR/boot/cdboot .

xorriso -as mkisofs -R -J \
  -b cdboot -no-emul-boot \
  -o $OS_NAME.iso $WORK_DIR
