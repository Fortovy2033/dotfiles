# ~~~~~~~~~~ ZINIT INSTALL ~~~~~~~~~

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# ~~~~~~~~~~ ENV ~~~~~~~~~~~~~~~~~~~

# Path

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/sbin:$PATH
export PATH=/usr/share/dotnet:$PATH

export DATE=$(date +%Y-%m-%d)

# Directories

export REPOS="$HOME/Repos"
export GHREPOS="$REPOS/github.com/"
export DOTFILES="$REPOS/dotfiles"
export SCRIPTS="$REPOS/scripts"

# ZSH Autosuggestion Colors

typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=green
ZSH_HIGHLIGHT_STYLES[alias]=none
ZSH_HIGHLIGHT_STYLES[builtin]=none
ZSH_HIGHLIGHT_STYLES[function]=none
ZSH_HIGHLIGHT_STYLES[command]=none
ZSH_HIGHLIGHT_STYLES[precommand]=none
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=none
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[globbing]=none
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[assign]=none


# ~~~~~~~~~~ HISTORY ~~~~~~~~~~~~~~~

setopt APPENDHISTORY
setopt SHAREHISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

HISTFILE=~/.zsh_history
HISTSIZE=4096
SAVEHIST=$HISTSIZE
HISTDUP=erase


# ~~~~~~~~~~ KEYBINDS ~~~~~~~~~~~~~~

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^e' end-of-line
bindkey '^d' backward-delete-word
bindkey 'M\f' menu-complete

bindkey '^h' backward-word
bindkey '^l' forward-word
bindkey '^hh' beginning-of-line
bindkey '^ll' end-of-line


# ~~~~~~~~~~ ALIASES ~~~~~~~~~~~~~~~

# Basic Comands

alias s="sudo"
alias sv="sudo nvim"
alias v="nvim"
alias c="clear"
alias src="source ~/.zshrc"
alias syu="sudo pacman -Syu"

# Repos

alias scripts="cd $SCRIPTS"
alias dot="cd $DOTFILES"
alias gr="cd $GHREPOS"
alias repos="cd $REPOS"

# Git

alias gp="git pull"
alias glg="git --no-pager log"
#alias lg="lazygit"

# Docker

alias d="docker"
alias dc="docker-compose"
#alias ld="lazydocker"

# Kubernetes

#alias k="kubectl"
#alias kgp="kubectl get pods"
#alias kc="kubectx"
#alias kn="kubens"

# ls

alias ls='eza -a --icons --width=3 --group-directories-first --hyperlink'
alias lg='eza -a --icons --width=3 --git --group-directories-first --hyperlink'
alias ll='eza -halb --icons --width=3 --total-size --group-directories-first --hyperlink'


# ~~~~~~~~~~ PLUGINS ~~~~~~~~~~~~~~~

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


# ~~~~~~~~~~ COMPLETION ~~~~~~~~~~~~

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# ~~~~~~~~~ SNIPPETS ~~~~~~~~~~~~~~~

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

autoload -U compinit && compinit
zinit cdreplay -q


# ~~~~~~~~~~ INTEGRATIONS ~~~~~~~~~~

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"


# ~~~~~~~~~~ STARSHIP ~~~~~~~~~~~~~~
eval "$(starship init zsh)"
