# auto boot for tmux
# if [ $SHLVL = 1 ] ; then
#     tmux
# fi

# GPG
# export GPG_TTY=$TTY

# With bat
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# lsd
# alias lsd="lsd --date '+%Y-%m-%d_%H:%M:%S'"

# ---------------------------------------------------------------
# commands

# function zipDeleteDSStoreMACOSX(){
#     /usr/bin/zip --delete $@ "*__MACOSX*" "*.DS_Store"
# }

# alias cdw='cd-work-repository'
# function cd-work-repository () {
#     local ROOT=$HOME/work
#     local WDIR=$(
#                 find $ROOT -type d -maxdepth 2 \
#                 | fzf --delimiter=/ --reverse +m --with-nth=4.. --inline-info --border --preview "tree -L 1 {} | head -100" --prompt="Directory > "
#             )
#
#     if [ -n "$WDIR" ]; then
#         echo $WDIR
#         cd $WDIR
#     else
#         pwd
#         return 1
#     fi
# }

