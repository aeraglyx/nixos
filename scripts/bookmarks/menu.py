import os
import json
import html

file_in = os.path.expanduser("~/.local/share/bookmarks/bookmarks.json")


def markup(text):
    return f"<span foreground='#525252'>{text}</span>"


def walk(node, path=None):

    if path is None:
        path = []

    if "url" in node:

        path_str = ""
        if path:
            delimiter = " / "
            path_str = delimiter.join(path) + delimiter
            path_str = markup(path_str)

        name = node.get("name", "[]")
        name = html.escape(name)

        url = markup(node["url"])

        full_path_str = path_str + name + " " + url
        print(full_path_str)

    elif "children" in node:
        new_path = path + [node["name"]]
        for child in node["children"]:
            walk(child, new_path)


with open(file_in) as f:
    data = json.load(f)


for node in data:
    walk(node)

