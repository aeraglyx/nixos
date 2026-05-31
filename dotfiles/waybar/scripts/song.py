import subprocess

MAX_LENGTH = 48

def is_song_playing():
    args = ["playerctl", "--player=spotify", "status"]
    status = subprocess.check_output(args, stderr=subprocess.DEVNULL).decode().strip()
    return status == "Playing"

def get_song_info():
    args = ["playerctl", "--player=spotify", "metadata", "--format", "{{ artist }} | {{ title }}"]
    song_info = subprocess.check_output(args).decode().strip()
    if len(song_info) > MAX_LENGTH:
        song_info = song_info[:MAX_LENGTH-3].rstrip(".") + "..."
    return song_info

try:
    if is_song_playing():
        print(get_song_info())
    else:
        print("")
except:
    print("")
