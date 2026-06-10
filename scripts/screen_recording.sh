if pgrep -f "gpu-screen-recorder" > /dev/null; then
    pkill -SIGINT -f "gpu-screen-recorder"
    # pkill -TERM -f "showmethekey"
else
    # showmethekey-gtk -kAC &
    videos_dir=~/videos
    gpu-screen-recorder \
        -w portal \
        -restore-portal-session yes \
        -f 25 -a default_input \
        -o $videos_dir/rec_"$(date +"%Y%m%dT%H%M%S")".mp4 &
fi
