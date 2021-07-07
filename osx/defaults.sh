#!/usr/bin/env bash

# disable Character Accents Popup and enable Key Repeat when holding down a key
defaults write -g ApplePressAndHoldEnabled -bool false

# you could use Karabiner as well
defaults write -g InitialKeyRepeat -float 10.0  # 166ms
defaults write -g KeyRepeat -float 1.2          # 20ms
# Use all Fn keys as standard function keys
defaults write -g com.apple.keyboard.fnState -bool true

# iTerm2 config
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/.config/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true