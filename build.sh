#!/bin/sh
# Pamplemouche Core - ISO Builder
export OS_NAME="PamplemoucheCore"
export WORK_DIR="./build_out"

echo "--- Préparation de l'image Pamplemouche Core ---"
rm -rf $WORK_DIR
mkdir -p $WORK_DIR

# 1. On copie tes fichiers de configuration
cp -R config/* $WORK_DIR/

# 2. LA CORRECTION : On importe manuellement le chargeur de boot du système
# Cela garantit que xorriso le trouvera dans l'image
mkdir -p $WORK_DIR/boot
cp /boot/cdboot $WORK_DIR/boot/cdboot

echo "--- Création de l'ISO Bootable ---"
# 3. Maintenant on utilise le chemin RELATIF (sans le slash au début pour cdboot)
xorriso -as mkisofs -R -J \
  -b boot/cdboot -no-emul-boot \
  -o $OS_NAME.iso $WORK_DIR
