if command -v "asdf" >/dev/null 2>&1; then
    export ASDF_CONFIG_FILE=$XDG_CONFIG_HOME/asdf/asdfrc
    export ASDF_DATA_DIR=$XDG_DATA_HOME/asdf
    export PATH="$ASDF_DATA_DIR/shims:$PATH"

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
