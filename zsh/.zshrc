autoload -U compinit
compinit -u

# Zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-rust \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-bin-gem-node
### End of Zinit's installer chunk
### Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light olivierverdier/zsh-git-prompt
zinit light asdf-vm/asdf

# Completion
zstyle ':completion:*' menu select

# Prompt
autoload -U colors && colors
autoload -U promptinit && promptinit
setopt prompt_subst

PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[white]%}%m:%{$fg_no_bold[yellow]%}%1~%{$reset_color%}%# "
# RPROMPT="[%?]%{$fg_no_bold[yellow]%}%3d%{$reset_color%}"

precmd () {
    local st=`git status 2> /dev/null`
    if [[ -z "$st" ]]; then RPROMPT="[%?]%{$fg_no_bold[yellow]%}%3d%{$reset_color%}"
    else RPROMPT='[%?]$(git_super_status)'
    fi
}

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}%{ %G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[magenta]%}%{x%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[red]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[red]%}%{-%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{✔%G%}"

# Key Bind
bindkey -d
bindkey -e

# cd
setopt auto_pushd
setopt pushd_ignore_dups

# History
export HISTFILE=$HOME/.zhistory
export HISTSIZE=10000
export SAVEHIST=100000
setopt hist_reduce_blanks
zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}
    # 以下の条件をすべて満たすものだけをヒストリに追加する
    [[ ${#line} -ge 4 # 5文字以上
        && ${line} != (l[sal]|lla)
        && ${line} != (history|histories)
        && ${line} != (nvim|nvims)
        && ${line} != tig
        && ${line} != tmux
        && ${cmd}  != pwd
        && ${cmd}  != fg
    ]]
}

# Zsh
# REPORTTIME=1 # 1秒以上かかった処理はtimeする

# Path
export PATH=$HOME/.bin:$PATH

# Alias
alias grep="grep --color=auto"
alias ls="ls -FG"
alias ll="ls -l"
alias la="ls -A"
alias lla="ls -lA"
alias sudo='sudo env PATH=$PATH' # sudo with PATH
# alias -g @less=" | less -iNRS" # read it at less

# ---------------------------------------------------------------
ZSHMY_PATH=$HOME/.zshmy
source $ZSHMY_PATH/common.zsh
source $ZSHMY_PATH/local.zsh
