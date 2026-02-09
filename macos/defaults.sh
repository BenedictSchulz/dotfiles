#!/usr/bin/env bash
#
# macOS Essential Defaults
# Run once on a fresh Mac, then restart (or log out / log in).

set -euo pipefail

echo "Applying macOS defaults..."

# Close System Preferences to prevent overriding changes
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

# ============================================================
# Dock
# ============================================================
# Set Dock icon size (pixels)
defaults write com.apple.dock tilesize -int 48
# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true
# Remove the auto-hide delay
defaults write com.apple.dock autohide-delay -float 0
# Speed up the auto-hide animation
defaults write com.apple.dock autohide-time-modifier -float 0.3
# Don't show recent apps in Dock
defaults write com.apple.dock show-recents -bool false
# Minimize windows using scale effect
defaults write com.apple.dock mineffect -string "scale"

# ============================================================
# Finder
# ============================================================
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Default to list view in all Finder windows
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# Don't show warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Set home directory as default Finder location
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# ============================================================
# Keyboard
# ============================================================
# Fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
# Short delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Disable smart quotes and dashes (annoying when coding)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# ============================================================
# Trackpad
# ============================================================
# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# ============================================================
# Screenshots
# ============================================================
# Save screenshots to ~/Screenshots
mkdir -p "${HOME}/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"
# Save screenshots as PNG
defaults write com.apple.screencapture type -string "png"
# Disable screenshot shadow
defaults write com.apple.screencapture disable-shadow -bool true

# ============================================================
# Apply changes
# ============================================================
echo "Restarting affected applications..."
for app in "Dock" "Finder" "SystemUIServer"; do
    killall "${app}" 2>/dev/null || true
done

echo "macOS defaults applied. Some changes may require a logout/restart."
