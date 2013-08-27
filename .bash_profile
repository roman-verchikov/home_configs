[ -d /usr/local/bin ] && PATH=/usr/local/bin:$PATH

# add some colors to the prompt
PS1="\[$(tput bold)\]\[$(tput setaf 1)\]\u\[$(tput sgr0)\]@\[$(tput setaf 5)\]\h\[$(tput setaf 3)\] \W\[$(tput sgr0)\]\\$ "

# PS1='\u@\h: \W\$ '

export VAGRANT_DEFAULT_PROVIDER='vmware_fusion'

[ -e ~/bash_completion ] && . ~/bash_completion

alias ls='ls -G'
alias ll='ls -lAh'
alias la='ls -a'
alias l='ls'
alias ssh='ssh -A'

alias grep='grep --color=always'

vagrant() {
    local vagrantdir=~/Documents/apple/openstack/stackinthebox/
    local savedir=$PWD

    cd $vagrantdir
    command vagrant $@
    cd $savedir
}
