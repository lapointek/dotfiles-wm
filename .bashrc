#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- User environment variables ---
# Set default terminal
export TERMINAL=foot
# Set default editor
export EDITOR=nvim

# --- Source .inputrc ---
# Apply .inputrc changes on sourcing .bashrc
bind -f ~/.inputrc

# --- History options ---
HISTTIMEFORMAT='%y-%m-%d %H:%M '
HISTCONTROL=ignoredups:erasedups:ignorespace
HISTSIZE=5000
HISTFILESIZE=10000

# Ensure command history is updated and synchronized across multiple sessions
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# Do not overwrite the history file upon exit of terminal session
shopt -s histappend

# --- Optional shell features ---
# Update terminal
shopt -s checkwinsize
# cd into directory automatically
shopt -s autocd
# Auto-correct typos in directory names
shopt -s cdspell
# Save multi-line commands
shopt -s lithist
# Store multi-line commands as a single history entry
shopt -s cmdhist
# Warn before exiting if background jobs are running
shopt -s checkjobs

# --- Aliases ---
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -a --color=auto'
alias lla='ls -la --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'

# Move to the parent folder.
alias ..='cd ..;pwd'
# Move up two parent folders.
alias ...='cd ../..;pwd'
# Move up three parent folders.
alias ....='cd ../../..;pwd'
# Press c to clear the terminal screen.
alias c='clear'
# Press h to view the bash history.
alias h='history'

# --- Shell integration ---
osc7_cwd() {
    local strlen=${#PWD}
    local encoded=""
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=${PWD:$pos:1}
        case "$c" in
            [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'${c}" ;;
        esac
        encoded+="${o}"
    done
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+${PROMPT_COMMAND%;}; }osc7_cwd

# --- Yazi setup --- 
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# --- FZF setup ---
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# Rosé Pine fzf theme
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

# --- Execute shell commands ---
# Set starship prompt
eval "$(starship init bash)"
# Set zoxide
eval "$(zoxide init bash)"

