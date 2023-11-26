#!/bin/bash

timedatectl set-timezone America/Sao_Paulo
systemctl enable autorandr
systemctl enable docker

usermod -aG docker oliveira
chsh -s /bin/zsh oliveira
