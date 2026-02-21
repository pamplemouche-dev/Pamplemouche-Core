#!/bin/sh
# Pamplemouche Core - ISO Builder Ultra-Stable
export OS_NAME="PamplemoucheCore"
export WORK_DIR="./build_out"

echo "--- 1. Nettoyage ---"
rm -rf $WORK_DIR
mkdir -p $WORK_DIR

echo "--- 2. Téléchargement (Liens directs) ---"
# On télécharge les fichiers dans le dossier courant
# On ajoute -v pour voir si le téléchargement avance vraiment
fetch -v https://download.freebsd.org/releases/amd64/14.0-RELEASE/base.txz || exit 1
fetch -v https://download.freebsd.org/releases/amd64/14.0-RELEASE/kernel.txz || exit 1

echo "--- 3. Extraction ---"
tar -xf base.txz -C $WORK_DIR || exit 1
tar -xf kernel.txz -C $WORK_DIR || exit 1

echo "--- 4. Personnalisation Pamplemouche ---"
if [ -d "config" ]; then
    cp -R config/* $WORK_DIR/
fi

echo "--- 5. Préparation du Boot ---"
# On prend le bootloader qu'on vient de télécharger, pas celui du système
cp $WORK_DIR/boot/cdboot .

echo "--- 6. Création de l'ISO ---"
xorriso -as mkisofs -R -J \
  -b cdboot -no-emul-boot \
  -o $OS_NAME.iso $WORK_DIR
