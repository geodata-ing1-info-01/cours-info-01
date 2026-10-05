#!/usr/bin/env bash
# Vide les caches de VS Code : Git Bash sous Windows, macOS, Linux.
#   bash vider_cache_vscode.sh         caches de l'application
#   bash vider_cache_vscode.sh --tout  et aussi l'état des dossiers ouverts et
#                                      les données des extensions Python et Jupyter
# Ne touche ni à settings.json ni aux extensions installées.

case "$(uname -s)" in
  MINGW* | MSYS*)
    dossier="$(/usr/bin/cygpath -u "$APPDATA")/Code"
    ouvert() { tasklist 2>/dev/null | grep -qi '^Code\.exe'; } ;;
  Darwin)
    dossier="$HOME/Library/Application Support/Code"
    ouvert() { pgrep -x 'Code' >/dev/null || pgrep -x 'Electron' >/dev/null; } ;;
  *)
    dossier="${XDG_CONFIG_HOME:-$HOME/.config}/Code"
    ouvert() { pgrep -x 'code' >/dev/null; } ;;
esac

if ouvert; then
  echo "VS Code est ouvert : le fermer, puis relancer ce script."
  exit 1
fi

if [ ! -d "$dossier" ]; then
  echo "Dossier introuvable : $dossier"
  exit 1
fi

supprimer() {
  if [ -e "$dossier/$1" ]; then
    rm -rf "$dossier/$1"
    echo "supprimé : $dossier/$1"
  fi
}

for nom in "Cache" "CachedData" "CachedExtensionVSIXs" "Code Cache" "GPUCache"; do
  supprimer "$nom"
done

if [ "$1" = "--tout" ]; then
  for nom in "User/workspaceStorage" \
             "User/globalStorage/ms-python.python" \
             "User/globalStorage/ms-python.vscode-python-envs" \
             "User/globalStorage/ms-toolsai.jupyter"; do
    supprimer "$nom"
  done
fi

echo "Terminé. Relancer VS Code."
