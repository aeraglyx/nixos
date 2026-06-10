menu_src="$(python ~/scripts/bookmarks/menu.py)"
bookmark=$(echo "$menu_src" | rofi -dmenu -i -p "bookmarks" -markup-rows)

if [ -n "$bookmark" ]; then
    url=$(echo "$bookmark" | awk 'NF>1{print $NF}' )
    url="${url:21:-7}"
    wl-copy "$url"
    notify-send "Copied to Clipboard" --urgency=low
fi
