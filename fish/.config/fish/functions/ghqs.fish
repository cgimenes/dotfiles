function ghqs
    if not command -v ghq >/dev/null
        echo "ghq not found" >&2
        return 1
    end
    if not command -v gum >/dev/null
        echo "gum not found" >&2
        return 1
    end

    set header "REPO|BRANCH|STATUS|AHEAD/BEHIND"
    set dirty_rows
    set clean_rows
    set other_rows

    for repo in (ghq list --full-path)
        set name (basename "$repo")

        if test ! -d "$repo/.git"
            set label (gum style --foreground 240 "not a git repo")
            set -a other_rows "$name|-|$label|-"
            continue
        end

        set branch (git -C "$repo" symbolic-ref --short -q HEAD 2>/dev/null)
        if test -z "$branch"
            set branch (git -C "$repo" rev-parse --short HEAD)
        end
        switch $branch
            case main master
                set branch (gum style --foreground 6 "$branch")
            case '*'
                set branch (gum style --foreground 3 "$branch")
        end

        set upstream (git -C "$repo" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
        if test -n "$upstream"
            git -C "$repo" rev-list --left-right --count "HEAD...@{u}" 2>/dev/null | read -l ahead behind
            set ab_text "+$ahead/-$behind"
            if test "$behind" -gt 0
                set ahead_behind (gum style --foreground 1 "$ab_text")
            else if test "$ahead" -gt 0
                set ahead_behind (gum style --foreground 2 "$ab_text")
            else
                set ahead_behind (gum style --foreground 240 "$ab_text")
            end
        else
            set ahead_behind (gum style --foreground 3 "no upstream")
        end

        set repo_diff (git -C "$repo" status --porcelain)
        if test -z "$repo_diff"
            set repo_status (gum style --foreground 2 "clean")
            set -a clean_rows "$name|$branch|$repo_status|$ahead_behind"
        else
            set repo_status (gum style --foreground 1 "dirty")
            set -a dirty_rows "$name|$branch|$repo_status|$ahead_behind"
        end
    end

    set all_rows $dirty_rows $clean_rows $other_rows

    begin
        printf '%s\n' $header
        printf '%s\n' $all_rows
    end | gum table --separator "|" -p
end
