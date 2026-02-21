#!/bin/sh
# Pamplemouche Core - ISO Builder (Version Auto-Patch)
export OS_NAME="PamplemoucheCore"
export WORK_DIR="./build_out"

echo "--- 1. Nettoyage ---"
rm -rf $WORK_DIR base.txz kernel.txz
mkdir -p $WORK_DIR

echo "--- 2. Téléchargement (Méthode de secours) ---"
# On essaie le miroir principal en HTTP (plus fiable sur GitHub)
# On utilise la 14.1 qui est la plus sûre actuellement
SITE="http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/14.1-RELEASE"

fetch ${SITE}/base.txz || fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/14.1-RELEASE/base.txz || exit 1
fetch ${SITE}/kernel.txz || fetch http://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/14.1-RELEASE/kernel.txz || exit 1

echo "--- 3. Extraction ---"
tar -xf base.txz -C $WORK_DIR
tar -xf kernel.txz -C $WORK_DIR

echo "--- 4. Configuration Pamplemouche ---"
if [ -d "config" ]; then
    cp -R config/* $WORK_DIR/
fi

echo "--- 5. Préparation du Boot ---"
cp $WORK_DIR/boot/cdboot .

echo "--- 6. Création de l'ISO ---"
xorriso -as mkisofs -R -J \
  -b cdboot -no-emul-boot \
  -o $OS_NAME.iso $WORK_DIR
