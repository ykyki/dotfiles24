# cd*
HOME_TEMP=$HOME/htemp
alias cdt='cd $HOME_TEMP; pwd'

alias cdd='cd $HOME/dotfiles24 && git fetch'

alias cdgt='cd $(git rev-parse --show-toplevel); pwd'
alias cdg='cd-git-repository && git fetch'
alias cdgq='cd-git-repository'
function cd-git-repository () {
    local ROOT=$(ghq root)
    local REPO=$(
        ghq list \
        | fzf \
        --delimiter=/ \
        --reverse \
        +m \
        --inline-info \
        --border \
        --preview "tree -L 1 $ROOT/{} | head -100" \
        --prompt="Repository > "
    )
    if   [ -n "$REPO" ]; then
        echo $REPO
        cd $ROOT/$REPO
    else
        pwd
        return 1
    fi
}

alias cppath='copypath'
function copypath() {
    local TARGETPATH=''

    if   [ $# = 0 ]; then
        TARGETPATH=$(pwd)
    elif [ $# = 1 ]; then
        TARGETPATH=$(readlink -f $1)
    fi

    echo $TARGETPATH

    if   [ -n $TARGETPATH ]; then
        echo -n $TARGETPATH | gocopy
    else
        echo 'usage: copypath [target]'
    fi
}

function passgen {
    local passlen=${1:-32}
    LC_ALL=C < /dev/urandom tr -cd '0-9A-Za-z!@#$%^&*' | tr -d '0Oo1Il' | head -c $passlen
}

alias memo="vim -c Memo"

