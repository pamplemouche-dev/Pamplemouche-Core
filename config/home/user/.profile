# --- DÉMARRAGE PAMPLEMOUCHE CORE ---

# Si on est sur le terminal principal (ttyv0), on lance l'interface
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/ttyv0" ]; then
    echo "Lancement de Pamplemouche Core..."
    
    # Configuration pour Wayland (plus fluide sur iPad/PC récents)
    export XDG_RUNTIME_DIR=/var/run/user/$(id -u)
    export XDG_SESSION_TYPE=wayland
    
    # On lance le moteur de fenêtres que tu as configuré à l'étape précédente
    exec wayfire
fi
