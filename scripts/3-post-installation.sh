#!/bin/bash

cd $HOME/dotfiles/distrobox/
make archlinux
make php

gem install thor
