import os
import json
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-n", "--name", type=str)
parser.add_argument("-u", "--url", type=str, required=True)
args = parser.parse_args()

file = os.path.expanduser("~/.local/share/bookmarks/bookmarks.json")

with open(file) as f:
    data = json.load(f)

data.insert(0, {"name": args.name, "url": args.url})

with open(file, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=4, ensure_ascii=False)

