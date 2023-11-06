dotfile () {
    if [[ $1 == "i3" ]]
    then
      $EDITOR ~/.config/i3/config
    fi
    if [[ $1 == "polybar" ]]
    then
      $EDITOR ~/.config/polybar/config
    fi
    if [[ $1 == "picom" ]]
    then
      $EDITOR ~/.config/picom.conf
    fi
}
