if [[ -d /opt/asdf-vm ]]; then
  . /opt/asdf-vm/asdf.sh
fi

zinit wait lucid for OMZP::asdf

ASDF_PLUGINS=(
  java
  python
)
ASDF_PLUGINS_ALREADY_INSTALLED=$(asdf plugin list)

for PLUGIN in $ASDF_PLUGINS; do
  if ! (($ASDF_PLUGINS_ALREADY_INSTALLED[(Ie)$PLUGIN])); then
    echo "Adding plugin '$PLUGIN' to asdf"
    asdf plugin-add $PLUGIN
  fi
done