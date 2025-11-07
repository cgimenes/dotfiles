# Git clone and add to zoxide
function clone {
  ghq get $@
  ghq list | xargs -I {} zoxide add -s 0 $(ghq root)/{}
}
