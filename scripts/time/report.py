import os
import argparse

from datetime import datetime, timedelta
from zoneinfo import ZoneInfo


parser = argparse.ArgumentParser()
parser.add_argument("project", type=str)
parser.add_argument("-g", "--graph", action="store_true")
parser.add_argument("-d", "--day", action="store_true")
parser.add_argument("-m", "--month", action="store_true")
parser.add_argument("-n", type=int, default=0)

args = parser.parse_args()


report_start = None
report_end = None

if args.month or args.day:
    report_start = datetime.now(ZoneInfo("Europe/Prague"))
    report_start = report_start.replace(hour=0, minute=0, second=0, microsecond=0)

    if args.month:
        report_start = report_start.replace(day=1)
        report_end = report_start
        report_start = report_start - timedelta(days=1)
        report_start = report_start.replace(day=1)
    elif args.day:
        report_start = report_start.replace(hour=12)
        report_start = report_start - timedelta(days=args.n)
        report_start = report_start.replace(hour=0)


dir = os.path.expanduser("~/.local/share/time/data")
file = os.path.join(dir, args.project)

def get_entry_data(file):

    data = []
    with open(file) as f:
        for line in f:

            date_str_start = line[00:25]
            dt_start = datetime.fromisoformat(date_str_start)

            try:
                date_str_end = line[26:51]
                dt_end = datetime.fromisoformat(date_str_end)
            except IndexError:
                dt_end = datetime.now()

            data.append((dt_start, dt_end))

    return data


total_sec = 0
data = get_entry_data(file)

for entry in data:

    dt_start, dt_end = entry

    # TODO: precise splitting
    if report_start:
        # if dt_start.timestamp() < report_start.timestamp():
        if dt_start < report_start:
            continue

    if report_end:
        if dt_start >= report_end:
            continue

    sec = (dt_end - dt_start).total_seconds()
    total_sec += sec


hours = total_sec / 3600
print(f"{hours:.1f} h")


if args.graph:

    import matplotlib.pyplot as plt
    # import math

    x = []
    dt = 15  # seconds between "ticks", lower for more precision
    for entry in data:
        start = int(entry[0].timestamp())
        end = int(entry[1].timestamp())
        tick = start
        while tick <= end:
            dt_tick = datetime.fromtimestamp(tick)
            hour = dt_tick.hour + dt_tick.minute / 60 + dt_tick.second / 3600
            x.append(hour)
            tick += dt

    fig, ax = plt.subplots(figsize=(12, 6))
    ax.set_xticks(range(0, 25))

    # bins = int(2 * math.cbrt(len(x)))
    bins = 24 * 6

    interval_sec = (data[-1][0] - data[0][0]).total_seconds()
    weight = dt / interval_sec
    weights = [weight * bins for _ in x]

    ax.hist(x, bins=bins, weights=weights, cumulative=False, density=False)

    plt.show()

