autoload -Uz compinit && compinit -u

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

## Plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice depth=1; zinit light romkatv/gitstatus
zinit light asdf-vm/asdf

## Completion
zstyle ':completion:*' menu select

## Prompt
autoload -U colors && colors
autoload -U promptinit && promptinit
setopt prompt_subst
### romkatv/gitstatus: https://github.com/romkatv/gitstatus
function my_set_prompt() {
    PROMPT=''
    PROMPT+="%{$fg[green]%}%n%{$reset_color%}"
    PROMPT+='@'
    PROMPT+="%{$fg[white]%}%m"
    PROMPT+=':'
    PROMPT+="%{$fg[yellow]%}%1~%{$reset_color%}"
    PROMPT+='%#'
    PROMPT+=' '
    RPROMPT=''
    RPROMPT+='[%?]'
    if gitstatus_query MY && [[ $VCS_STATUS_RESULT == ok-sync ]]; then
        RPROMPT+="%{$fg[yellow]%}"
        RPROMPT+='@'
        RPROMPT+=${${VCS_STATUS_LOCAL_BRANCH:-@${VCS_STATUS_COMMIT}}//\%/%%}  # escape %
        RPROMPT+="%{$reset_color%}"
        RPROMPT+='|'
        (( VCS_STATUS_COMMITS_BEHIND )) && RPROMPT+="%{$fg[blue]%}"    && RPROMPT+='⇣' && RPROMPT+=$VCS_STATUS_COMMITS_BEHIND && RPROMPT+="%{$reset_color%}"
        (( VCS_STATUS_COMMITS_AHEAD  )) && RPROMPT+="%{$fg[green]%}"   && RPROMPT+='⇡' && RPROMPT+=$VCS_STATUS_COMMITS_AHEAD  && RPROMPT+="%{$reset_color%}"
        (( VCS_STATUS_NUM_STAGED     )) && RPROMPT+="%{$fg[green]%}"   && RPROMPT+='+' && RPROMPT+=$VCS_STATUS_NUM_STAGED    && RPROMPT+="%{$reset_color%}"
        (( VCS_STATUS_NUM_UNSTAGED   )) && RPROMPT+="%{$fg[red]%}"     && RPROMPT+='!' && RPROMPT+=$VCS_STATUS_NUM_UNSTAGED  && RPROMPT+="%{$reset_color%}"
        (( VCS_STATUS_NUM_UNTRACKED  )) && RPROMPT+="%{$fg[red]%}"     && RPROMPT+='?' && RPROMPT+=$VCS_STATUS_NUM_UNTRACKED && RPROMPT+="%{$reset_color%}"
        (( VCS_STATUS_NUM_CONFLICTS  )) && RPROMPT+="%{$fg[magenta]%}" && RPROMPT+='x' && RPROMPT+=$VCS_STATUS_NUM_CONFLICTS && RPROMPT+="%{$reset_color%}"
        (( VCS_STATUS_NUM_CHANGED    )) && RPROMPT+="%{$fg[red]%}"     && RPROMPT+='%' && RPROMPT+=$VCS_STATUS_NUM_CHANGED   && RPROMPT+="%{$reset_color%}"
    else
        RPROMPT+="%{$fg[yellow]%}"
        RPROMPT+='%3d'
        RPROMPT+="%{$reset_color%}"
    fi
    setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
}
gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
autoload -Uz add-zsh-hook
add-zsh-hook precmd my_set_prompt

## Key Bind
bindkey -d
bindkey -e

## cd
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
        && ${line} != (nvim|nvims)
        && ${line} != tig
        && ${line} != tmux
        && ${cmd}  != pwd
        && ${cmd}  != fg
        && ${cmd}  != tldr
        && ${cmd}  != history
        && ${cmd}  != (l[sal]|lla)
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
