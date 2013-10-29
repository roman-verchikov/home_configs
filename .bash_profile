[ -d /usr/local/bin ] && PATH=/usr/local/bin:$PATH

# add some colors to the prompt
username="\[$(tput bold)\]\[$(tput setaf 2)\]\u\[$(tput sgr0)\]"
hostname="\[$(tput setaf 5)\]\h\[$(tput sgr0)\]"
workdir="\[$(tput setaf 4)\]\W\[$(tput sgr0)\]"
dollarsign="\[$(tput setaf 4)\]\$\[$(tput sgr0)\]"
gitbranch='\[$(tput setaf 6)\]$(__git_ps1)\[$(tput sgr0)\]'

export PS1="${username}@${hostname} ${workdir}${gitbranch} ${dollarsign} "
export EDITOR=vim

LS_CMD=$(which ls)

ls_colorize_opt='--color'
if [ $(uname) = 'Darwin' ]; then
    export VAGRANT_DEFAULT_PROVIDER='vmware_fusion'

    # use gnu coreutils whenever possible
    if [ $(which gls) ]; then
        LS_CMD=$(which gls)
    else
        ls_colorize_opt='-G'
    fi

    if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
        . $(brew --prefix)/share/bash-completion/bash_completion
    fi
elif [ $(uname -o) = 'Cygwin' ]; then
    # Add SSH keys to keychain to avoid entering passwords all the time
    # required for cygwin environment only
    keychain $HOME/.ssh/id_rsa
    source $HOME/.keychain/$HOSTNAME-sh
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
    'rverchikov-pc'     ) export VAGRANT_CWD=/home/rverchikov/workspace/vagrant         ;;
    'rverchikov-laptop' ) export VAGRANT_CWD=C:/Users/Roman/Documents/Workspace/vagrant ;;
    'rverchikov-mac'    ) export VAGRANT_CWD=~/Documents/apple/openstack/stackinthebox  ;;
esac

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi
