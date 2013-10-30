#!/bin/bash

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

vim <<EOF
:BundleInstall!
:qall!
EOF
