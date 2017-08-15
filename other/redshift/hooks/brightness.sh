#!/bin/sh

# Set brightness via xbrightness when redshift status changes
# Works only with Intel

# Set brightness values for each status.
# Range from 1 to 100 is valid
brightness_day="100"
brightness_transition="85"
brightness_night="75"
# Set fade time for changes to one minute
fade_time=6000

case $1 in
	period-changed)
		case $3 in
			night)
				xbacklight -set $brightness_night -time $fade_time
				;;
			transition)
				xbacklight -set $brightness_transition -time $fade_time
				;;
			daytime)
				xbacklight -set $brightness_day -time $fade_time
				;;
		esac
		;;
esac
