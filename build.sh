#!/bin/sh
# Pamplemouche Core - ISO Builder (Correctif 14.1)
export OS_NAME="PamplemoucheCore"
export WORK_DIR="./build_out"

echo "--- 1. Nettoyage ---"
rm -rf $WORK_DIR base.txz kernel.txz
mkdir -p $WORK_DIR

echo "--- 2. Téléchargement (Liens vérifiés 14.1) ---"
# Utilisation de la version 14.1 qui est l'actuelle sur les serveurs
fetch https://download.freebsd.org/releases/amd64/14.1-RELEASE/base.txz || exit 1
fetch https://download.freebsd.org/releases/amd64/14.1-RELEASE/kernel.txz || exit 1

echo "--- 3. Extraction (Construction du système) ---"
tar -xf base.txz -C $WORK_DIR
tar -xf kernel.txz -C $WORK_DIR

echo "--- 4. Injection de Pamplemouche Core ---"
if [ -d "config" ]; then
    cp -R config/* $WORK_DIR/
fi

echo "--- 5. Préparation du secteur de boot ---"
# On s'assure de prendre le chargeur de la version qu'on vient de télécharger
cp $WORK_DIR/boot/cdboot .

echo "--- 6. Création de l'ISO finale ---"
xorriso -as mkisofs -R -J \
  -b cdboot -no-emul-boot \
  -o $OS_NAME.iso $WORK_DIR
