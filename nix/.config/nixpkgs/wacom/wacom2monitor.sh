#!/usr/bin/env bash

# Source: https://gist.github.com/Konfekt/d57567b84b264e37e62bd5c001e76457
# Details: https://wiki.archlinux.org/title/Graphics_tablet#Mapping_the_tablet_to_a_monitor
#
# Script modified to use HEAD-0, HEAD-1 etc. until Nvidia drivers support xrandr 1.2 or later.
# See xsetwacom man page for MapToOutput parameter for more details.

usage() {
  cat << EOF
Usage: $0 <Monitor>

Map all Wacom Devices to Monitor <Monitor>.
For example, to map to Monitor VGA-1:

  $0 VGA-1

If <Monitor> is NEXT, then to the next monitor
as listed by xrandr. Useful, for example, to bind,
say by xbindkeys, a key to

  notify-send "\$(\$0 NEXT)"

EOF
  exit 1
}

[ -n "$TMPDIR" ] || TMPDIR=/tmp
WFILE="$TMPDIR/wacom2mon"

next() {
# Since
#   xsetwacom --get "Wacom Pad pad" MapToOutput
# returns
#   'MapToOutput' is a write-only option.
# we store the output device in a temp file.
# This, woefully, cannot detect output device changes;
# for example, after a reboot.

[ -f "$WFILE" ] && head="$(cat "$WFILE")"

monitors="$(xrandr --listactivemonitors | tail -n2 | awk '{print $4}')"
heads="$(echo "$monitors" | nl -v0 | awk '{print "HEAD-"$1}')"
monitors=($monitors)
heads=($heads)
num_monitors="${#monitors[@]}"
for ((i=0; i < num_monitors; i++)); do
  # trim trailing whitespaces; from https://stackoverflow.com/a/15398846
  h="$(echo "${heads[i]}")"
  if [ "$h" = "$head" ]; then
    found_monitor=1
    if [ "$((i + 1))" -eq "$num_monitors" ]; then
      monitor="${monitors[0]}"
      head="${heads[0]}"
    else
      monitor="${monitors[i+1]}"
      head="${heads[i+1]}"
    fi
    break
  fi
done
[ -z "$found_monitor" ] && head="${heads[0]}"

echo "$monitor"
echo "$head" > $WFILE
}

#command -v xsetwacom >/dev/null 2>&1 || exit 1
#echo "Wacom Devices:"
#echo ""
#xsetwacom --list devices | cut -f1
#
#echo ""
#
#command -v xrandr >/dev/null 2>&1 || exit 1
#echo "Monitors:"
#echo ""
#xrandr --listactivemonitors | tail -n2 |  awk '{print $4}'
#
#echo ""

if [[ $# == 0 ]]; then
  usage
else
  screen="$1"
fi

[ "$screen" = "NEXT" ] && screen="$(next)"

devices="$(xsetwacom --list devices | cut -f 1)"
[ -z "$devices" ] && exit 1

while read -r d; do
  # trim trailing whitespaces; from https://stackoverflow.com/a/15398846
  d="$(echo $d)"
  xsetwacom --set "$d" MapToOutput "$(cat $WFILE)"
  echo "Mapped $d to $screen"
done <<< $devices

