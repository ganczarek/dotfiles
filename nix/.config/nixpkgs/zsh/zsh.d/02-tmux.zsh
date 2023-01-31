# check if tmux is installed
if command -v tmux >/dev/null 2>&1; then
  # Don't use tmux inside emacs
  if [[ $TERM == "dumb" || $TERM == "" ]]; then
    :
  # don't use tmux inside JetBrains term emulator
  elif [[ $TERMINAL_EMULATOR =~ JetBrains ]]; then
    :
  # don't create nested tmux sessions
  elif [[ $TERM =~ screen ]]; then
    :
  else
    # create new tmux session for each window in i3
    if [[ $XDG_CURRENT_DESKTOP == i3 && -z $TMUX_SESSION ]]; then
      exec tmux new-session
    else
      exec tmux new-session -A -s "${TMUX_SESSION:-main}"
    fi
  fi
fi
