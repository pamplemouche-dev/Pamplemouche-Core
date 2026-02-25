#!/bin/sh
# Pamplemouche Core - Assemblage Final (Correction Chemins)
export OS_NAME="PamplemoucheCore"
export WORK_DIR="./build_out"

echo "--- 1. Reconstruction du système ---"
mkdir -p $WORK_DIR

# On vérifie si les fichiers sont bien là avant de continuer
ls -R freebsd-dist/

# On rassemble les morceaux en un seul fichier dans le dossier courant
cat freebsd-dist/base.txz.part* > base_rebuilt.txz

echo "--- 2. Extraction des composants ---"
# Extraction de la base reconstruite
tar -xf base_rebuilt.txz -C $WORK_DIR
# Extraction du kernel qui est resté entier
tar -xf freebsd-dist/kernel.txz -C $WORK_DIR

echo "--- 3. Customisation Pamplemouche ---"
if [ -d "config" ]; then
    cp -R config/* $WORK_DIR/
fi

echo "--- 4. Préparation du secteur de boot ---"
# On va chercher cdboot là où il a été extrait
cp $WORK_DIR/boot/cdboot .

echo "--- 5. Création de l'ISO bootable ---"
xorriso -as mkisofs -R -J \
  -b cdboot -no-emul-boot \
  -o $OS_NAME.iso $WORK_DIR
