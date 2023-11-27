#!/bin/bash

cd $HOME/dotfiles/distrobox/
make archlinux
make php

gem install thor
go install github.com/cheat/cheat/cmd/cheat@latest
