#!/usr/bin/env bash
#
# Dotfiles install script
# Usage: git clone <repo> ~/.dotfiles && cd ~/.dotfiles && ./install.sh
#

set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# ============================================================
# Symlink mapping: source (relative to dotfiles) → target
# ============================================================
link() {
    local src="${DOTFILES_DIR}/$1"
    local dest="$2"

    mkdir -p "$(dirname "$dest")"

    if [ -L "$dest" ]; then
        rm "$dest"
    elif [ -e "$dest" ]; then
        warn "Backing up existing $dest → ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi

    ln -sf "$src" "$dest"
    info "  $1 → $dest"
}

# ============================================================
# 1. Xcode Command Line Tools
# ============================================================
if ! xcode-select -p &>/dev/null; then
    info "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Press any key after Xcode CLI tools are installed..."
    read -n 1
else
    info "Xcode CLI tools already installed."
fi

# ============================================================
# 2. Homebrew
# ============================================================
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    info "Homebrew already installed."
fi

# ============================================================
# 3. Homebrew Bundle
# ============================================================
info "Installing packages from Brewfile..."
brew bundle --file="${DOTFILES_DIR}/Brewfile" --no-lock

# ============================================================
# 4. Symlink dotfiles
# ============================================================
info "Linking dotfiles..."

# Shell
link "zsh/.zshrc"       "${HOME}/.zshrc"
link "zsh/.zprofile"    "${HOME}/.zprofile"
link "zsh/.zshenv"      "${HOME}/.zshenv"

# Git
link "git/.gitconfig"         "${HOME}/.gitconfig"
link "git/.gitignore_global"  "${HOME}/.gitignore_global"

# Neovim
link "nvim"      "${HOME}/.config/nvim"

# Tmux
link "tmux"      "${HOME}/.config/tmux"

# Ghostty
link "ghostty"   "${HOME}/.config/ghostty"

# Alacritty
link "alacritty"  "${HOME}/.config/alacritty"

# AeroSpace
link "aerospace"  "${HOME}/.config/aerospace"

# Karabiner
link "karabiner"  "${HOME}/.config/karabiner"

# Lazygit
link "lazygit"    "${HOME}/.config/lazygit"

# Scripts
link "scripts"    "${HOME}/.config/scripts"

# ============================================================
# 5. Tmux Plugin Manager (TPM)
# ============================================================
TPM_DIR="${HOME}/.config/tmux/plugins/tpm"
if [ ! -d "${TPM_DIR}" ]; then
    info "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "${TPM_DIR}"
else
    info "TPM already installed."
fi

if command -v tmux &>/dev/null; then
    info "Installing tmux plugins..."
    "${TPM_DIR}/bin/install_plugins" || warn "Could not install tmux plugins. Start tmux and press prefix + I."
fi

# ============================================================
# 6. Neovim plugins (lazy.nvim bootstraps itself)
# ============================================================
info "Neovim plugins will install automatically on first launch."

# ============================================================
# 7. macOS defaults (optional)
# ============================================================
echo ""
read -p "Apply macOS defaults (Dock, Finder, keyboard, etc.)? [y/N] " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    info "Applying macOS defaults..."
    bash "${DOTFILES_DIR}/macos/defaults.sh"
fi

# ============================================================
# 8. Make scripts executable
# ============================================================
if [ -d "${HOME}/.config/scripts" ]; then
    info "Making scripts executable..."
    chmod +x "${HOME}/.config/scripts/"*
fi

# ============================================================
# Done
# ============================================================
echo ""
info "========================================="
info "  Dotfiles installation complete!"
info "========================================="
echo ""
warn "Remaining manual steps:"
echo "  1. Create ~/.env.local with your private env vars (deploy config, etc.)"
echo "  2. Set up SSH keys (copy from backup or generate new ones)"
echo "  3. Log into services (GitHub, etc.)"
echo "  4. Set Ghostty as default terminal (if desired)"
echo "  5. Restart your shell: exec zsh"
echo ""
