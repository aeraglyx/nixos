time_dir=~/stuff/time
scripts_dir=~/nixos/scripts

if [ ! -d "${time_dir}" ]; then
    notify-send "no time dir" --urgency=low
fi

project=$(
    find "${time_dir}/data" -mindepth 1 -printf "%T@_%P\n" |
    sort -nr |
    cut -d'_' -f2- |
    rofi -sep "\n" -dmenu -p "project"
) || exit 0


filter_options="total,today,yesterday,last month"
filter_chosen=$(echo -n "${filter_options}" | rofi -sep "," -dmenu -p "filter")

case $filter_chosen in
    "")             exit 0          ;;
    "total")        args=""         ;;
    "today")        args=" -d"      ;;
    "yesterday")    args=" -d -n=1" ;;
    "last month")   args=" -m"      ;;
esac

hours=$(python ${scripts_dir}/time/report.py "${project}${args}")
notify-send "${hours}" --urgency=low
