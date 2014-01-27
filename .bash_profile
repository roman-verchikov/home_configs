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

    # use gnu coreutils whenever possible
    if [[ $(which gls) ]]; then
        LS_CMD=$(which gls)
    else
        ls_colorize_opt='-G'
    fi

    if [[ -f $(brew --prefix)/share/bash-completion/bash_completion ]]; then
        . $(brew --prefix)/share/bash-completion/bash_completion
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

if is_installed __git_ps1; then
    gitbranch='\[$(tput setaf 6)\]$(__git_ps1)\[$(tput sgr0)\]'
else
    echo '__git_ps1 is not installed! You may probably want to install git completion' 1>&2
    gitbranch=''
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
    'rverchikov-pc'       ) export VAGRANT_CWD=/home/rverchikov/workspace/vagrant         ;;
    'rverchikov-laptop'   ) export VAGRANT_CWD=C:/Users/Roman/Documents/Workspace/vagrant ;;
    'rverchikov-mac'      ) export VAGRANT_CWD=~/Documents/apple/openstack/stackinthebox  ;;
    'rverchikov-mba.local') export VAGRANT_CWD=~/Documents/apple/openstack/stackinthebox/stackinthebox ;;
esac

if [[ -f ~/.bashrc.local ]]; then
    source ~/.bashrc.local
fi
