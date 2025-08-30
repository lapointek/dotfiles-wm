#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- User environment variables ---
# Set default editor
export EDITOR=nvim
# Set sudo editor value i.e. sudo -e
export SUDO_EDITOR=$EDITOR

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
# Updates terminal LINES and COLUMNS after each command
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
alias ls='eza --group-directories-first --icons=auto --git'
alias ll='ls -alF'
alias la='ls -A'
alias lt='eza --tree --level=2 --long --git'
alias l='ls -F'
alias grep='grep --color=auto'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

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

# --- fzf environment variables ---
# CTRL-Y to copy the command into clipboard using wl-copy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# Rosé Pine fzf theme
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

# --- Git integration ---
if [[ -f /usr/share/git/completion/git-completion.bash ]]; then
    source /usr/share/git/completion/git-completion.bash
fi
if [[ -f /usr/share/git/completion/git-prompt.sh ]]; then
    source /usr/share/git/completion/git-prompt.sh
fi

# --- Bash prompt ---
export PS1="\n\t \[\033[35m\]\w\[\033[32m\]\$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1)\[\033[00m\]\n$ "

# --- Bash completion ---
if [[ -r /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi

# --- Execute shell commands ---
if command -v fzf &> /dev/null; then
    # Set fzf key-bindings and completion
    eval "$(fzf --bash)"
fi
if command -v zoxide &> /dev/null; then
    # Set zoxide
    eval "$(zoxide init bash)"
fi
