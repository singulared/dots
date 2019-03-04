HISTFILE=$HOME/.zhistory
POWERLEVEL9K_MODE='nerdfont-fontconfig'

fpath+=~/.zfunc

source ~/.zplug/init.zsh

# Theme configuration
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"
POWERLEVEL9K_VI_INSERT_MODE_STRING="I"
POWERLEVEL9K_VI_COMMAND_MODE_STRING="N"
# POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{black} $(print_icon 'LEFT_SUBSEGMENT_SEPARATOR') %F{black}"
# POWERLEVEL9K_VIRTUALENV_FOREGROUND="024"
# POWERLEVEL9K_VIRTUALENV_FOREGROUND="254"
# POWERLEVEL9K_PYTHON_ICON=" "
POWERLEVEL9K_HOME_ICON=' '
POWERLEVEL9K_HOME_SUB_ICON=' '
POWERLEVEL9K_FOLDER_ICON=' '
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%{%F{249}%}\u250f"
# POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%{%F{249}%}\u2517%{%F{default}%} "
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vi_mode pyenv time)


# zplug configuration
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "plugins/command-not-found",   from:oh-my-zsh
zplug "plugins/django",   from:oh-my-zsh
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/git-flow",   from:oh-my-zsh
zplug "plugins/pip",   from:oh-my-zsh
zplug "plugins/pyenv",   from:oh-my-zsh
zplug "plugins/python",   from:oh-my-zsh
zplug "plugins/rust",   from:oh-my-zsh
zplug "plugins/vi-mode",   from:oh-my-zsh

zplug 'bhilburn/powerlevel9k', as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Configure systax highlight
ZSH_HIGHLIGHT_STYLES[path]='bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'

# Colorize substring search
# HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
# HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
# HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# History
setopt hist_ignore_all_dups
setopt share_history

# Completion
zstyle ':completion:*' menu select
setopt menu_complete

# Vi-mode
KEYTIMEOUT=1
bindkey -v
bindkey -M vicmd "?" history-incremental-search-backward
bindkey -M vicmd "/" history-incremental-search-forward

# Substrig search configuration
if zplug check zsh-users/zsh-history-substring-search; then
    # Vi
    bindkey -M vicmd "k" history-substring-search-up
    bindkey -M vicmd "j" history-substring-search-down

    # Up\Down
    bindkey '\eOA' history-substring-search-up
    bindkey '\eOB' history-substring-search-down
    # bindkey '^[[A' history-substring-search-up
    # bindkey '^[[B' history-substring-search-down

    # Back Tab
    bindkey -M viins "^[[Z" reverse-menu-complete
fi

# This should fix the error at the start of zsh session, but doesn't work :(
TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
