url="$(wl-paste)"
name="$(rofi -dmenu -p "Name" -l 0)"
python ~/scripts/bookmarks/add.py --name "$name" --url "$url"
notify-send "Saved to Bookmarks" --urgency=low
