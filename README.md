# Install Arch Linux

```sh
curl https://raw.githubusercontent.com/cgimenes/dotfiles/refs/heads/master/scripts/arch/user_configuration.json > user_configuration.json
archinstall --config user_configuration.json
su ...
cd
curl https://raw.githubusercontent.com/cgimenes/dotfiles/refs/heads/master/scripts/arch/1-post-installation.sh | bash
chsh -s /bin/zsh ...
```

