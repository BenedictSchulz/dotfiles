#!/bin/bash
CATEGORIES=(
	"WORK"
	"WASTE"
	"THINK!"
	"STOP"
)

selected=$(printf "%s\n" "${CATEGORIES[@]}" | fzf --height=30% --reverse --border=none \
	--header="Time" --prompt=" " --pointer="▶" \
	--bind 'tab:down,shift-tab:up' \
	--color=bg:#2d353b,fg:#d3c6aa,hl:#a7c080,fg+:#d3c6aa,bg+:#343f44,hl+:#a7c080,pointer:#a7c080,prompt:#a7c080)
fzf_status=$?

if [[ $fzf_status -ne 0 || -z "$selected" ]]; then
	exit 0
fi

tmux set -g status-interval 5

if [[ "$selected" == "STOP" ]]; then
	timew stop >/dev/null 2>&1
	tmux set -g status-right ""
	"/Applications/Cold Turkey Blocker.app/Contents/MacOS/Cold Turkey Blocker" -stop "THINK!" >/dev/null 2>&1
else
	timew start "$selected" >/dev/null 2>&1
	tmux set -g status-right "$selected #(timew | awk '/^ *Total/ {print \$NF}')"

	if [[ "$selected" == "WASTE" ]]; then
		hostess rm www.youtube.com >/dev/null 2>&1
		hostess rm www.reddit.com >/dev/null 2>&1
		hostess rm www.linkedin.com >/dev/null 2>&1
		hostess rm www.gmail.com >/dev/null 2>&1
	elif [[ "$selected" == "THINK!" ]]; then
		hostess add www.youtube.com 127.0.0.1 >/dev/null 2>&1
		hostess add www.reddit.com 127.0.0.1 >/dev/null 2>&1
		hostess add www.linkedin.com 127.0.0.1 >/dev/null 2>&1
		hostess add www.gmail.com 127.0.0.1 >/dev/null 2>&1
		"/Applications/Cold Turkey Blocker.app/Contents/MacOS/Cold Turkey Blocker" -start "THINK!" >/dev/null 2>&1

	else
		hostess add www.youtube.com 127.0.0.1 >/dev/null 2>&1
		hostess add www.reddit.com 127.0.0.1 >/dev/null 2>&1
		hostess add www.linkedin.com 127.0.0.1 >/dev/null 2>&1
		hostess add www.gmail.com 127.0.0.1 >/dev/null 2>&1
	fi
fi
