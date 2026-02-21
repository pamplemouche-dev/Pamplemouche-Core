#!/bin/sh
# Pamplemouche Core - Bootable ISO Builder
export OS_NAME="PamplemoucheCore"
export WORK_DIR="./build_out"

echo "--- Nettoyage ---"
rm -rf $WORK_DIR
mkdir -p $WORK_DIR

echo "--- Extraction de la base FreeBSD ---"
# On va chercher la base du système (le noyau et les commandes)
# GitHub Actions sous FreeBSD a déjà ces fichiers dans /usr/freebsd-dist/
if [ -d "/usr/freebsd-dist" ]; then
    tar -xf /usr/freebsd-dist/base.txz -C $WORK_DIR
    tar -xf /usr/freebsd-dist/kernel.txz -C $WORK_DIR
fi

echo "--- Injection de la couche Pamplemouche Tech ---"
# On écrase les fichiers de base par tes fichiers de config personnalisés
cp -R config/* $WORK_DIR/

echo "--- Finalisation de l'ISO ---"
# On s'assure que le bootloader est présent
cp /boot/cdboot $WORK_DIR/boot/cdboot

# On crée l'ISO
xorriso -as mkisofs -R -J \
  -b boot/cdboot -no-emul-boot \
  -o $OS_NAME.iso $WORK_DIR
