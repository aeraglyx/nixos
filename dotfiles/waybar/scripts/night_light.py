import subprocess
import datetime
import json

TEMP_DAY = 6500
TEMP_NIGHT = 4500

def get_temp(hour):
    a1 = 6
    b1 = 10
    a2 = 20
    b2 = 24

    t1 = (hour - b1) / (a1 - b1)
    t2 = (hour - a2) / (b2 - a2)
    t1 = min(max(t1, 0.0), 1.0)
    t2 = min(max(t2, 0.0), 1.0)
    t = max(t1, t2)

    temp = (1.0 - t) * TEMP_DAY + t * TEMP_NIGHT

    return int(temp)

def set_temp(temp):
    args = ["hyprctl", "hyprsunset", "temperature", str(temp)]
    if temp == TEMP_DAY:
        args = ["hyprctl", "hyprsunset", "identity"]
    subprocess.run(args, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

try:
    time = datetime.datetime.now().time()
    hour = time.hour + time.minute / 60
    temp = get_temp(hour)
    set_temp(temp)

    out = {}
    out["text"] = f"{round(temp, -2)}K"
    out["tooltip"] = "Color Temperature"
    if temp < TEMP_DAY:
        out["class"] = "warm"

    print(json.dumps(out))

except:
    print("")

