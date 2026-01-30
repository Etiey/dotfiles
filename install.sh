#!/bin/bash

# S'assure que le script s'arrête si une commande échoue
set -e

echo "=== Début de l'installation ==="

# 1. Mise à jour et installation des paquets
echo "--- Mise à jour du système et installation des dépendances ---"
sudo apt update

# Installation des paquets détectés dans vos fichiers de config
# (.bashrc, .vimrc, i3/config)
sudo apt install -y \
    git vim curl tree build-essential \
    i3 i3-wm i3status i3lock dmenu dex \
    xss-lock network-manager-gnome pulseaudio-utils \
    feh numlockx maim xclip xdotool \
    trash-cli python3-pip python3-venv \
    pipx

# Fastfetch (peut ne pas être dans les dépôts par défaut selon la version d'Ubuntu/Debian)
if sudo apt install -y fastfetch; then
    echo "Fastfetch installé."
else
    echo "Avertissement : Fastfetch non trouvé, tentative d'installation via le PPA (si Ubuntu)..."
    # Décommentez les lignes suivantes si vous êtes sur Ubuntu et que fastfetch manque
    # sudo add-apt-repository ppa:zhangsongcui333666/fastfetch -y
    # sudo apt update && sudo apt install -y fastfetch
fi

# 2. Préparation des répertoires cibles
echo "--- Création des dossiers nécessaires ---"
mkdir -p "$HOME/Pictures"
mkdir -p "$HOME/.config/i3"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.virtualenvs"

# 3. Correction des chemins "en dur" (/home/etienne)
# On modifie les fichiers dans le dossier actuel pour qu'ils pointent vers le nouveau HOME
echo "--- Correction des chemins absolus dans les fichiers de config ---"
CURRENT_USER=$(whoami)
CURRENT_HOME=$HOME

# On remplace /home/etienne par le dossier home actuel
# Note : Cela modifie vos fichiers locaux.
sed -i "s|/home/etienne|$CURRENT_HOME|g" .bashrc
sed -i "s|/home/etienne|$CURRENT_HOME|g" i3/config

echo "Chemins mis à jour vers : $CURRENT_HOME"

# 4. Création des liens symboliques
echo "--- Création des liens symboliques ---"
# Récupère le chemin absolu du dossier actuel où se trouve le script
DOTFILES_DIR=$(pwd)

echo "Source des fichiers : $DOTFILES_DIR"

# Sauvegarde des existants (au cas où) et création des liens
[ -f "$HOME/.bashrc" ] && mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
echo "Lien créé : ~/.bashrc -> $DOTFILES_DIR/.bashrc"

[ -f "$HOME/.vimrc" ] && mv "$HOME/.vimrc" "$HOME/.vimrc.bak"
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
echo "Lien créé : ~/.vimrc -> $DOTFILES_DIR/.vimrc"

[ -f "$HOME/.config/i3/config" ] && mv "$HOME/.config/i3/config" "$HOME/.config/i3/config.bak"
ln -sf "$DOTFILES_DIR/i3/config" "$HOME/.config/i3/config"
echo "Lien créé : ~/.config/i3/config -> $DOTFILES_DIR/i3/config"

# 5. Configuration Python et Node
echo "--- Configuration des environnements ---"

# Recréation de l'environnement virtuel pour l'alias 'ju' (Jupyter)
if [ ! -d "$HOME/.virtualenvs/masi-py3" ]; then
    echo "Création du venv Python 'masi-py3'..."
    python3 -m venv "$HOME/.virtualenvs/masi-py3"
    
    # Installation des outils Python requis dans le venv
    source "$HOME/.virtualenvs/masi-py3/bin/activate"
    pip install --upgrade pip
    pip install jupyter sqlfluff
    deactivate
    echo "Environnement masi-py3 créé."
else
    echo "L'environnement masi-py3 existe déjà."
fi

# Installation de NVM (Node Version Manager)
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installation de NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Configuration pipx path
python3 -m pipx ensurepath

# 6. Finition
echo "=== Installation terminée ! ==="
echo "Actions restantes pour vous :"
echo "1. Assurez-vous que l'image de fond d'écran est bien dans : $HOME/Pictures/hades2.png"
echo "2. Redémarrez votre session ou lancez 'source ~/.bashrc'"
echo "3. Recharge
