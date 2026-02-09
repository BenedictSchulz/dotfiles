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
			--header="Session" --prompt=" " --pointer="▶" \
			--bind 'tab:down,shift-tab:up' \
			--color=bg:#2d353b,fg:#d3c6aa,hl:#a7c080,fg+:#d3c6aa,bg+:#343f44,hl+:#a7c080,pointer:#a7c080,prompt:#a7c080)
	[[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

# Use directory name as session name, replace dots with underscores (tmux doesn't like dots)
selected_name=$(basename "$selected" | tr '.' '_')

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
	tmux new-session -s "$selected_name" -c "$selected"
	exit 0
fi

# If session already exists, just switch to it
if tmux has-session -t="$selected_name" 2>/dev/null; then
	if [[ -z $TMUX ]]; then
		tmux attach -t "$selected_name"
	else
		tmux switch-client -t "$selected_name"
	fi
	exit 0
fi

# Create new session and switch to it
tmux new-session -ds "$selected_name" -c "$selected"

if [[ -z $TMUX ]]; then
	tmux attach -t "$selected_name"
else
	tmux switch-client -t "$selected_name"
fi
