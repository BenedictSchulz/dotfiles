if [[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit -i
fi

bindkey -v

autoload -U colors && colors

git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
    echo " %F{180}${branch}%f"
}

setopt PROMPT_SUBST
PROMPT='%F{109}%~%f$(git_branch) %(?.%F{144}.%F{174})>%f '

export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.config/scripts:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"

if command -v rbenv &>/dev/null; then
    eval "$(rbenv init -)"
fi

if [[ -s "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias rz="source ~/.zshrc"
alias cd="z"
alias ls="lsd -l"
alias lg="lazygit"

alias oc='tmux split-window -h && tmux select-pane -T "opencode" && tmux send-keys "opencode" Enter && tmux select-pane -t .-'

venv() {
    for name in .venv venv; do
        if [[ -f "$PWD/$name/bin/activate" ]]; then
            source "$PWD/$name/bin/activate"
            return 0
        fi
        if [[ -f "$PWD/$name" ]]; then
            local venv_path=$(cat "$PWD/$name")
            if [[ -f "$venv_path/bin/activate" ]]; then
                source "$venv_path/bin/activate"
                return 0
            fi
        fi
    done
    echo "No virtual environment found in $PWD"
    return 1
}

if command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
    tmux attach -t main || tmux new -s main
fi

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

# Source local env vars (not tracked in git)
if [[ -f ~/.env.local ]]; then
    source ~/.env.local
fi
