#!/bin/sh
# Pamplemouche Core - ISO Builder (Architecture amd64)
export OS_NAME="PamplemoucheCore"
export WORK_DIR="./build_out"

echo "--- 1. Nettoyage ---"
rm -rf $WORK_DIR *.iso
mkdir -p $WORK_DIR

echo "--- 2. Téléchargement de l'image (Lien Officiel) ---"
# On utilise la version 13.4 qui est ultra-stable pour l'émulation iPad
fetch https://download.freebsd.org/releases/amd64/amd64/ISO-IMAGES/13.4/FreeBSD-13.4-RELEASE-amd64-bootonly.iso || exit 1

echo "--- 3. Montage et Préparation ---"
# On extrait le contenu pour pouvoir injecter notre logo Pamplemouche
tar -xf FreeBSD-13.4-RELEASE-amd64-bootonly.iso -C $WORK_DIR

echo "--- 4. Customisation Pamplemouche ---"
# On place tes fichiers de config par-dessus le système de base
if [ -d "config" ]; then
    cp -R config/* $WORK_DIR/
fi

echo "--- 5. Création de l'ISO bootable ---"
# On utilise le chargeur de démarrage extrait de l'image officielle
cp $WORK_DIR/boot/cdboot .

xorriso -as mkisofs -R -J \
  -b cdboot -no-emul-boot \
  -o $OS_NAME.iso $WORK_DIR
