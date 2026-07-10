function clone
    ghq get $argv
    set root (ghq root)
    for repo in (ghq list)
        zoxide add -s 0 $root/$repo
    end
end
