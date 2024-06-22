bindkey -v
setopt autocd
setopt extendedglob
setopt nomatch

# History
# ---------------------------------------------------------------------------------------------------------------------

export HISTFILE="$HOME/.cache/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE


# Prompt
# ---------------------------------------------------------------------------------------------------------------------
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{1} %b%u%c%f'
zstyle ':vcs_info:git*' unstagedstr '*'
zstyle ':vcs_info:git*' stagedstr '+'
zstyle ':vcs_info:*:*' check-for-changes true

autoload -Uz colors && colors
autoload -Uz promptinit && promptinit

setopt PROMPT_SUBST
RPROMPT='%F{8}%*%f %(?.%F{2}.%F{1})%f'
PROMPT='
%F{8}┌%f %F{4}%~%f ${vcs_info_msg_0_}
%F{8}└─%f '

# Auto completion with tab
# ---------------------------------------------------------------------------------------------------------------------
autoload -U compinit
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ":completion:*" menu select
zstyle ":completion:*" list-colors ""
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Search dot files

# Use vim keys in tab complete menu:
# ---------------------------------------------------------------------------------------------------------------------
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Switch directories and bind it to control-o
# ---------------------------------------------------------------------------------------------------------------------
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Alias
# ---------------------------------------------------------------------------------------------------------------------
alias ls="ls --color=auto"
alias pacman="yay"

# CMake GNU
alias dbcmake="cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=g++ -DCMAKE_GENERATOR=Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
alias rlcmake="cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++ -DCMAKE_GENERATOR=Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
alias cdbcmake="cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_COMPILER=gcc -DCMAKE_GENERATOR=Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
alias crlcmake="cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=gcc -DCMAKE_GENERATOR=Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
# CMake Clang
alias dbcmake_clang="cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_GENERATOR=Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
alias rlcmake_clang="cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_GENERATOR=Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
alias cdbcmake_clang="cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_COMPILER=clang -DCMAKE_GENERATOR=Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=1"
alias crlcmake_clang="cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=clang -DCMAKE_GENERATOR=Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=1"

# Plugins
# ---------------------------------------------------------------------------------------------------------------------
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/zsh-completions/zsh-completions.plugin.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
