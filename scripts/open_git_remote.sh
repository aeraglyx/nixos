url=$(git remote get-url origin)

if [[ $url == *github.com* ]]; then
    if [[ $url == git@* ]]; then
        url="${url#git@}"
        url="${url/:/\/}"
        url="https://$url"
    fi
    echo "opening $url"
    xdg-open "$url" & disown
else
    echo "can't open $url"
fi
