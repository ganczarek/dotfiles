# disable Character Accents Popup and enable Key Repeat when holding down a key
defaults write -g ApplePressAndHoldEnabled -bool false

# you could use Karabiner as well
defaults write -g InitialKeyRepeat -float 10.0  # 166ms
defaults write -g KeyRepeat -float 1.2          # 20ms
