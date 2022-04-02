if [[ -d /opt/asdf-vm ]]; then
    export ASDF_DIR=/opt/asdf-vm
    export ASDF_CONFIG_FILE=$XDG_CONFIG_HOME/asdf/asdfrc
    export ASDF_DATA_DIR=$XDG_DATA_HOME/asdf

    source /opt/asdf-vm/asdf.sh

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
fi
