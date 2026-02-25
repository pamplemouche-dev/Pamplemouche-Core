#!/bin/sh
# Pamplemouche Core - Assemblage Final
export OS_NAME="PamplemoucheCore"
export WORK_DIR="./build_out"

echo "--- 1. Reconstruction du système ---"
mkdir -p $WORK_DIR
# On rassemble les morceaux de 50Mo que tu as poussé
cat freebsd-dist/base.txz.part* > base_rebuilt.txz

echo "--- 2. Extraction des composants ---"
tar -xf base_rebuilt.txz -C $WORK_DIR
tar -xf freebsd-dist/kernel.txz -C $WORK_DIR

echo "--- 3. Customisation Pamplemouche ---"
# On injecte tes fichiers de config (logo, dock, etc.)
if [ -d "config" ]; then
    cp -R config/* $WORK_DIR/
fi

echo "--- 4. Préparation du secteur de boot ---"
# On récupère le chargeur de démarrage tout juste extrait
cp $WORK_DIR/boot/cdboot .

echo "--- 5. Création de l'ISO bootable ---"
xorriso -as mkisofs -R -J -b cdboot -no-emul-boot -o $OS_NAME.iso $WORK_DIR
