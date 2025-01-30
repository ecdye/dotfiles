#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
while [[ -h $SOURCE ]]; do
  BASEDIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="${BASEDIR}/$SOURCE"
done
BASEDIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

# Function to create symlinks
create_symlink() {
  local src=$1
  local dest=$2
  if [ -h "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    echo "Backup existing $dest to $dest.bak"
    mv "$dest" "$dest.bak"
  fi
  ln -s "$src" "$dest"
  echo "Created symlink: $src -> $dest"
}

# Symlink dotfiles
echo "Creating symlinks for dotfiles..."
create_symlink "$BASEDIR/.gitconfig" "$HOME/.gitconfig"
create_symlink "$BASEDIR/.bash_profile" "$HOME/.bash_profile"

# Symlink into config folder
mkdir -p "$HOME/.config"

echo "Creating symlinks for Neovim configuration..."
create_symlink "$BASEDIR/nvim" "$HOME/.config/nvim"

echo "Creating symlinks for Ghostty configuration..."
create_symlink "$BASEDIR/ghostty" "$HOME/.config/ghostty"

echo "Creating symlinks for GnuPG configuration..."
mkdir -p "$HOME/.gnupg"
create_symlink "$BASEDIR/gnupg/common.conf" "$HOME/.gnupg/common.conf"
create_symlink "$BASEDIR/gnupg/gpg.conf" "$HOME/.gnupg/gpg.conf"
[ -h "$HOME/.gnupg/gpg-agent.conf" ] && rm "$HOME/.gnupg/gpg-agent.conf"
sed -e 's|PINENTRYPATH|'"$BASEDIR"'/gpg-pinentry|' "$BASEDIR/gnupg/gpg-agent.conf" > "$HOME/.gnupg/gpg-agent.conf"
chown -R "$USER" "$HOME/.gnupg"

echo "Bootstrap and symlink creation complete!"
