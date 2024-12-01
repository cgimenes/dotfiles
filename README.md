# Install Arch Linux

```sh
rmmod pcspkr
rmmod snd_pcsp
iwctl station wlan0 connect "..."
curl https://raw.githubusercontent.com/cgimenes/dotfiles/refs/heads/master/scripts/arch/user_configuration.json > setup.json
archinstall --config setup.json
su ...
cd
curl https://raw.githubusercontent.com/cgimenes/dotfiles/refs/heads/master/scripts/arch/1-post-installation.sh | bash
chsh -s /bin/zsh ...
```

