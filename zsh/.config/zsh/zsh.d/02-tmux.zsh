# check if tmux is installed
if command -v tmux >/dev/null 2>&1; then
   # Don't use tmux inside emacs (dumb or empty $TERM') or IntelliJ (JetBrains term emulator)
   if [[ $TERM != "dumb" && $TERM != "" && ! $TERM =~ screen && $XDG_CURRENT_DESKTOP != i3 && ! $TERMINAL_EMULATOR =~ JetBrains ]]; then
      exec tmux new-session -A -s main
   fi
fi