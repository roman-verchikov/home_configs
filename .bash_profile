[ -d /usr/local/bin ] && PATH=/usr/local/bin:$PATH

# add some colors to the prompt
PS1="\[$(tput bold)\]\[$(tput setaf 1)\]\u\[$(tput sgr0)\]@\[$(tput setaf 5)\]\h\[$(tput setaf 3)\] \W\[$(tput sgr0)\]\\$ "


if [ $(uname) = 'Darwin' ]; then
    export VAGRANT_DEFAULT_PROVIDER='vmware_fusion'

    alias ls='ls -G'
else
    alias ls='ls --color'
fi

alias ll='ls -lAh'
alias la='ls -a'
alias l='ls'
alias ssh='ssh -A'
alias df='df -h'
alias du='du -h'

alias grep='grep --color=always'

if [ $(uname -o) = 'Cygwin' ]; then
    # Add SSH keys to keychain to avoid entering passwords all the time
    # required for cygwin environment only
    keychain $HOME/.ssh/id_rsa
    source $HOME/.keychain/$HOSTNAME-sh
fi

case $HOSTNAME in
    'rverchikov-pc'     ) export VAGRANT_CWD=/home/rverchikov/workspace/vagrant           ;;
    'rverchikov-laptop' ) export VAGRANT_CWD=C:/Users/Roman/Documents/Workspace/openstack ;;
    *                   ) export VAGRANT_CWD=~/Documents/apple/openstack/stackinthebox    ;;
esac

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi
