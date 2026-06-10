choices="weather
time / report
calculate
countdown
color picker
calendar
calendar -s
translate / cz to en
translate / en to cz
ocr
wallpaper"

action=$(echo -n "$choices" | rofi -sep "\n" -dmenu -p stuff -sort)

run_script() {
    script_dir=$HOME/nixos/scripts
    sh "$script_dir/$1"
}

case $action in
    "")
        exit 0
        ;;
    "time / report")
        run_script time/report.sh
        ;;
    "calculate")
        run_script calc.sh
        ;;
    "countdown")
        run_script countdown.sh
        ;;
    "color picker")
        sleep 0.12 ; hyprpicker
        ;;
    "calendar")
        ghostty --class=popup.app.high -e bash -c "python ~/projects/calendar/list.py; exec bash"
        ;;
    "calendar -s")
        ghostty --class=popup.app.high -e bash -c "python ~/projects/calendar/list.py -s; exec bash"
        ;;
    "translate / cz to en")
        in="$(rofi -dmenu -p "cz" -l 0)"
        out=$(trans -brief -s cs -t en "$in")
        notify-send "$out" --urgency=low
        ;;
    "translate / en to cz")
        in="$(rofi -dmenu -p "en" -l 0)"
        out=$(trans -brief -s en -t cs "$in")
        notify-send "$out" --urgency=low
        ;;
    "wallpaper")
        run_script wallpaper.sh
        ;;
    "ocr")
        region="$(slurp -c "#8b8b8b" -b "#14141488")"
        grim -g "$region" - | tesseract - - | awk '{$1=$1};1' | wl-copy
        ;;
    "weather")
        weather_fmt=$(curl "wttr.in/?format=temp:+%t\nfeel:+%f\nrain:+%p\nwind:+%w")
        notify-send "$weather_fmt"
        ;;
    *)
        notify-send "bruh" --urgency=low
        ;;
esac
