time_minutes="$(rofi -dmenu -p "minutes" -l 0)"
sleep $((time_minutes * 60))
notify-send "it's time, bro" --urgency=critical
