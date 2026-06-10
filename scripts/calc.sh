in="$(rofi -dmenu -p "calc" -l 0)"
out=$(qalc -t "$in")
echo -n "$out" | wl-copy
notify-send "$out" --urgency=low
