function git_main_branch
    command git rev-parse --git-dir >/dev/null 2>&1; or return
    for ref in refs/{heads,remotes/{origin,upstream}}/{main,master}
        if command git show-ref -q --verify $ref
            path basename $ref
            return 0
        end
    end

    # If no main branch was found, fall back to master but return error
    echo master
    return 1
end
