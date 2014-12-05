if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
fi

function is_installed() {
    hash ${1} &>/dev/null
}

[[ -d /usr/local/bin ]] && PATH=/usr/local/bin:$PATH

export EDITOR=vim

LS_CMD=$(which ls)

ls_colorize_opt='--color'
if [[ $(uname) = 'Darwin' ]]; then
    export VAGRANT_DEFAULT_PROVIDER='virtualbox'
    export LC_ALL='en_US.UTF-8'
    export LC_CTYPE='en_US.UTF-8'
    export LANG='en_US.UTF-8'

    # use gnu coreutils whenever possible
    if [[ $(which gls) ]]; then
        LS_CMD=$(which gls)
    else
        ls_colorize_opt='-G'
    fi

    if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
        . $(brew --prefix)/etc/bash_completion
    fi
elif [[ $(uname -o) = 'Cygwin' ]]; then
    # Add SSH keys to keychain to avoid entering passwords all the time
    # required for cygwin environment only
    keychain $HOME/.ssh/id_rsa
    source $HOME/.keychain/$HOSTNAME-sh
fi

# add some colors to the prompt
username="\[$(tput setaf 2)\]\u\[$(tput sgr0)\]"
hostname="\[$(tput setaf 5)\]\h\[$(tput sgr0)\]"
workdir="\[$(tput setaf 4)\]\W\[$(tput sgr0)\]"
dollarsign="\[$(tput setaf 4)\]\$\[$(tput sgr0)\]"

gitbranch=''
if is_installed __git_ps1; then
    # Don't use __git_ps1 when it's painfully slow or failing
    # see https://gist.github.com/bps/883177
    git_status=$(__git_ps1 "(%s)")
    [[ $? != 130 ]] && gitbranch='\[$(tput setaf 6)\]$(__git_ps1)\[$(tput sgr0)\]'
else
    echo '__git_ps1 is not installed! You may probably want to install git completion' 1>&2
fi

export PS1="${username}@${hostname} ${workdir}${gitbranch} ${dollarsign} "

# Syntax highligh for GNU less
if is_installed src-hilite-lesspipe.sh; then
    export LESSOPEN="| $(which src-hilite-lesspipe.sh) %s"
    export LESS='-R'
fi

alias ls="${LS_CMD} --group-directories-first $ls_colorize_opt"
alias ll='ls -lAh'
alias la='ls -a'
alias l='ls'
alias ssh='ssh -A'
alias df='df -h'
alias du='du -h'

alias grep='grep --color=always'

case $HOSTNAME in
    rverchikov-pc*     ) export VAGRANT_CWD=/home/rverchikov/workspace/vagrant         ;;
    rverchikov-laptop* ) export VAGRANT_CWD=C:/Users/Roman/Documents/Workspace/vagrant ;;
    rverchikov-mac*    ) export VAGRANT_CWD=~/Documents/apple/openstack/stackinthebox  ;;
    rverchikov-mba*    ) export VAGRANT_CWD=~/Documents/mystackinthebox ;;
esac

if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi

function no_comments() {
    local file=$1
    sed -r '/(#.*)|(^\s*$)/d' $file
}

function git_log() {
    local branch=$1
    local depth=${2:-50}

    git log -n "${depth}" --oneline "${branch}" | sed -E 's/^[0-9a-z]{7} //'
}

function copy_over_ssh() {
    # Copies compressed dir over SSH and unpacks it remotely
    #
    # Usage:
    #   copy_over_ssh REMOTE [LOCAL_PATH] [REMOTE_PATH]
    local remote=$1
    local local_path=${2:-.}
    local remote_path=${3:-/tmp}
    local usage=$(cat << EOF
Copies compressed dir over SSH and unpacks it remotely

Usage:
  copy_over_ssh REMOTE [LOCAL_PATH] [REMOTE_PATH]
EOF
)

    [[ -z $remote ]] && echo "$usage" && return

    tar -cf - $local_path | ssh $remote "(cd ${remote_path}; tar -xpf -)"
}

