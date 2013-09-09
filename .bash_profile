[ -d /usr/local/bin ] && PATH=/usr/local/bin:$PATH

# add some colors to the prompt
PS1="\[$(tput bold)\]\[$(tput setaf 1)\]\u\[$(tput sgr0)\]@\[$(tput setaf 5)\]\h\[$(tput setaf 3)\] \W\[$(tput sgr0)\]\\$ "


if [ $(uname) = 'Darwin' ]; then
    export VAGRANT_DEFAULT_PROVIDER='vmware_fusion'

    vagrant() {
        local vagrantdir=~/Documents/apple/openstack/stackinthebox/
        local savedir=$PWD

        cd $vagrantdir
        command vagrant $@
        cd $savedir
    }

    alias ls='ls -G'
else
    alias ls='ls --color'
fi

alias ll='ls -lAh'
alias la='ls -a'
alias l='ls'
alias ssh='ssh -A'

alias grep='grep --color=always'

