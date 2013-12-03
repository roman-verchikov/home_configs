#!/bin/bash

vundle_path=${HOME}/.vim/bundle/vundle
if [[ -d ${vundle_path} ]]; then
    git --git-dir=${vundle_path}/.git pull origin master
else
    git clone https://github.com/gmarik/vundle.git ${vundle_path}
fi

vim +BundleInstall! +qall!
