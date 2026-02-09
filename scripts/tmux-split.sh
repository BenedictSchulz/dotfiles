#!/bin/bash

DIRS=(
	"$HOME/workspace"
	"$HOME/uni"
	"$HOME/.config"
	"$HOME/schulzbenedict/"

)

if [[ $# -eq 1 ]]; then
	selected=$1
else
	selected=$(fd . "${DIRS[@]}" --type=dir --max-depth=5 |
		sed "s|^$HOME/||" |
		fzf --height=100% --reverse --border=none \
			--header="Split" --prompt=" " --pointer="▶" \
			--bind 'tab:down,shift-tab:up' \
			--color=bg:#2d353b,fg:#d3c6aa,hl:#a7c080,fg+:#d3c6aa,bg+:#343f44,hl+:#a7c080,pointer:#a7c080,prompt:#a7c080)
	[[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

if [[ -z $TMUX ]]; then
	echo "This script must be run from within a tmux session"
	exit 1
fi

pane_count=$(tmux list-panes | wc -l)

if [[ $pane_count -eq 1 ]]; then
	tmux split-window -h -c "$selected"
else
	tmux split-window -v -c "$selected"
fi
