#!/bin/sh
# Pamplemouche Core - ISO Builder (Version Stable)
export OS_NAME="PamplemoucheCore"
export WORK_DIR="./build_out"

echo "--- Nettoyage ---"
rm -rf $WORK_DIR
mkdir -p $WORK_DIR

echo "--- Téléchargement du coeur du système ---"
# Ces liens sont les officiels pour l'architecture standard (amd64)
fetch https://download.freebsd.org/releases/amd64/14.0-RELEASE/base.txz
fetch https://download.freebsd.org/releases/amd64/14.0-RELEASE/kernel.txz

echo "--- Extraction (Installe les muscles de l'OS) ---"
tar -xf base.txz -C $WORK_DIR
tar -xf kernel.txz -C $WORK_DIR

echo "--- Ajout de la touche Pamplemouche Tech ---"
cp -R config/* $WORK_DIR/

echo "--- Préparation du démarrage ---"
# On récupère le fichier de boot dans ce qu'on vient d'extraire
cp $WORK_DIR/boot/cdboot .

echo "--- Création de l'ISO finale ---"
xorriso -as mkisofs -R -J \
  -b cdboot -no-emul-boot \
  -o $OS_NAME.iso $WORK_DIR
