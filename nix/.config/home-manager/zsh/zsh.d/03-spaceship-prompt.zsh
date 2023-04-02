zinit light denysdovhan/spaceship-prompt/

SPACESHIP_PROMPT_ORDER=(
  dir
  git
  docker
  venv
  #pyenv
  nix_shell
  aws
  line_sep # Line break
  exit_code # Exit code section
  char # Prompt character
)

# DIR
SPACESHIP_DIR_PREFIX="" # disable directory prefix, cause it's not the first section
SPACESHIP_DIR_TRUNC="1" # show only last directory

# GIT
SPACESHIP_GIT_PREFIX=""
SPACESHIP_GIT_BRANCH_SUFFIX="" # remove space after branch name
# Unwrap git status from `[...]`
SPACESHIP_GIT_STATUS_PREFIX=""
SPACESHIP_GIT_STATUS_SUFFIX=""

# PYENV
SPACESHIP_PYENV_PREFIX=""

# AWS
SPACESHIP_AWS_PREFIX=""
SPACESHIP_AWS_SYMBOL="☁️  "
