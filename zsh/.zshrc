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

### Plugins ###
zinit wait lucid blockf light-mode for \
    @'zsh-users/zsh-autosuggestions' \
    @'zsh-users/zsh-completions' \
    @'zdharma-continuum/fast-syntax-highlighting'
zinit ice depth=1; zinit light romkatv/gitstatus
# zinit wait lucid blockf light-mode as"program" from"gh-r" for \
#     atload'eval "$(zabrze init --bind-keys)"' \
#     Ryooooooga/zabrze

### Completion ###
zstyle ':completion:*' menu select

### Prompt ###
autoload -U colors && colors
autoload -U promptinit && promptinit
setopt prompt_subst
### romkatv/gitstatus: https://github.com/romkatv/gitstatus
function my_set_prompt() {
    # color: black, red, green, yellow, blue, magenta, cyan, white
    # see: man zshzle
    PROMPT=''
    if [[ -z "$MY_PROMPT_HIDE_USER_HOST" ]]; then
        PROMPT+="%{$fg[green]%}%n%{$reset_color%}"
        PROMPT+='@'
        PROMPT+="%{$fg[white]%}%m%{$reset_color%}"
        PROMPT+=':'
    fi
    PROMPT+="%{$terminfo[smul]$fg[yellow]%}%1~%{$reset_color%}"
    PROMPT+='%#'
    PROMPT+=' '
    setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
    my_set_rprompt
    RPROMPT=$MY_RPROMPT_FULL
}
function my_set_rprompt() {
    MY_RPROMPT_FULL=''
    MY_RPROMPT_FULL+='[%?]'
    if gitstatus_query MY && [[ $VCS_STATUS_RESULT == ok-sync ]]; then
        MY_RPROMPT_FULL+="%{$fg[yellow]%}"
        MY_RPROMPT_FULL+=${${VCS_STATUS_LOCAL_BRANCH:-@${VCS_STATUS_COMMIT}}//\%/%%}  # escape %
        MY_RPROMPT_FULL+="%{$reset_color%}"
        MY_RPROMPT_FULL+='|'
        (( VCS_STATUS_COMMITS_BEHIND )) && MY_RPROMPT_FULL+="%{$fg[blue]%}"    && MY_RPROMPT_FULL+='⇣' && MY_RPROMPT_FULL+=$VCS_STATUS_COMMITS_BEHIND && MY_RPROMPT_FULL+="%{$reset_color%}"
        (( VCS_STATUS_COMMITS_AHEAD  )) && MY_RPROMPT_FULL+="%{$fg[green]%}"   && MY_RPROMPT_FULL+='⇡' && MY_RPROMPT_FULL+=$VCS_STATUS_COMMITS_AHEAD  && MY_RPROMPT_FULL+="%{$reset_color%}"
        (( VCS_STATUS_NUM_STAGED     )) && MY_RPROMPT_FULL+="%{$fg[green]%}"   && MY_RPROMPT_FULL+='+' && MY_RPROMPT_FULL+=$VCS_STATUS_NUM_STAGED     && MY_RPROMPT_FULL+="%{$reset_color%}"
        (( VCS_STATUS_NUM_UNSTAGED   )) && MY_RPROMPT_FULL+="%{$fg[red]%}"     && MY_RPROMPT_FULL+='!' && MY_RPROMPT_FULL+=$VCS_STATUS_NUM_UNSTAGED   && MY_RPROMPT_FULL+="%{$reset_color%}"
        (( VCS_STATUS_NUM_UNTRACKED  )) && MY_RPROMPT_FULL+="%{$fg[red]%}"     && MY_RPROMPT_FULL+='?' && MY_RPROMPT_FULL+=$VCS_STATUS_NUM_UNTRACKED  && MY_RPROMPT_FULL+="%{$reset_color%}"
        (( VCS_STATUS_NUM_CONFLICTS  )) && MY_RPROMPT_FULL+="%{$fg[magenta]%}" && MY_RPROMPT_FULL+='x' && MY_RPROMPT_FULL+=$VCS_STATUS_NUM_CONFLICTS  && MY_RPROMPT_FULL+="%{$reset_color%}"
        (( VCS_STATUS_NUM_CHANGED    )) && MY_RPROMPT_FULL+="%{$fg[red]%}"     && MY_RPROMPT_FULL+='%' && MY_RPROMPT_FULL+=$VCS_STATUS_NUM_CHANGED    && MY_RPROMPT_FULL+="%{$reset_color%}"
    fi
    local CURRENT_TIME=$(date "+%H:%M:%S")
    MY_RPROMPT_FULL+="%{$fg[blue]%}[${CURRENT_TIME}]%{$reset_color%}"
}
function my_rprompt_toggle() {
    if [[ -n "$BUFFER" ]]; then
        if [[ -n "$RPROMPT" ]]; then
            RPROMPT=''
            zle reset-prompt
        fi
    else
        if [[ "$RPROMPT" != "$MY_RPROMPT_FULL" ]]; then
            RPROMPT=$MY_RPROMPT_FULL
            zle reset-prompt
        fi
    fi
}
gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
autoload -Uz add-zsh-hook
autoload -Uz add-zle-hook-widget
add-zsh-hook precmd my_set_prompt
add-zle-hook-widget line-pre-redraw my_rprompt_toggle

### General ###
export EDITOR='vim'

### cd ###
setopt auto_pushd
setopt pushd_ignore_dups

### Key Bind ###
bindkey -d # reset
bindkey -e # emacs
# bindkey -v # vim

### History ###
export HISTFILE=$XDG_STATE_HOME/zsh_history
export HISTSIZE=10000
export SAVEHIST=100000
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE # スペースで始まるコマンドを無視
setopt HIST_IGNORE_ALL_DUPS
zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}
    # 以下の条件をすべて満たすものだけをヒストリに追加する
    [[ ${#line} -ge 4 # 5文字以上
        && ${line} != vim
        && ${line} != nvim
        && ${line} != tig
        && ${line} != tmux
        && ${line} != (l[sal]|lla)
        && ${line} != history
        && ${cmd}  != pwd
        && ${cmd}  != fg
        && ${cmd}  != tldr
    ]]
}

### Path ###
typeset -gU PATH path
typeset -gU FPATH fpath
path=(
    '/usr/local/bin'(N-/)
    "$HOME/.local/bin"(N-)
    "$HOME/.local/share/mise/shims"(N-)
    '/opt/homebrew/bin'(N-/)
    '/opt/homebrew/opt/llvm/bin'(N-/)
    '/usr/bin'(N-/)
    '/bin'(N-/)
    '/usr/sbin'(N-/)
    '/sbin'(N-/)
    "$GOPATH/bin"(N-/)
    "$RUSTUP_HOME/bin"(N-/)
    "$CARGO_HOME/bin"(N-/)
    "$HOME/.elan/bin"(N-/)
    "$HOME/.deno/bin"(N-/)
    '/usr/local/texlive/2024/bin/universal-darwin'(N-)
    "$path[@]"
)

### Alias ###
export LSCOLORS=gxfxcxdxbxegedabagacad # for mac, see man ls
alias grep="grep --color=auto"
alias ls="ls -FG"
alias ll="ls -l"
alias la="ls -A"
alias lla="ls -lA"
# alias sudo='sudo env PATH=$PATH' # sudo with PATH
# alias -g @less=" | less -iNRS" # read it at less

### Others ###
zinit wait lucid light-mode as'null' id-as'local-init' \
    atinit'
        [[ $commands[fzf] ]] &&  source <(fzf --zsh)
        [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
        [[ $commands[mise] ]] && eval "$(mise activate zsh)"
        [[ $commands[podman] ]] && source <(podman completion zsh)
        [[ $commands[kubectl] ]] && source <(kubectl completion zsh)
        [[ $commands[uv] ]] && source <(uv generate-shell-completion zsh)
        [[ $commands[uvx] ]] && source <(uvx --generate-shell-completion zsh)
        source "$ZDOTDIR/common.zsh"
        source $ZDOTDIR/local.zsh
    ' \
    for 'zdharma-continuum/null'

