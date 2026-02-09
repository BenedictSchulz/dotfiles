#!/usr/bin/env bash

if [ -n "$TMUX" ]; then
    dir=$(tmux display-message -p "#{pane_current_path}")
else
    dir="$PWD"
fi

cd "$dir" || exit

if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Not a Git repo: $dir"
    exit 1
fi

url=$(git remote get-url origin 2>/dev/null || git remote get-url upstream 2>/dev/null)

if [[ -z "$url" ]]; then
    echo "No git remote found."
    exit 1
fi

if [[ $url == git@* ]]; then
    url=${url#git@}       
    url=${url/:/\/}      
    url="https://$url"
fi

url=${url%.git}

echo "Opening: $url"

if command -v open >/dev/null; then open "$url"
elif command -v xdg-open >/dev/null; then xdg-open "$url"
else echo "$url"
fi
