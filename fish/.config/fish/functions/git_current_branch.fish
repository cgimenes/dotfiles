# Outputs the name of the current branch
# Usage example: git pull origin (git_current_branch)
# '--quiet' with 'symbolic-ref' avoids fatal error (128) if not a symbolic
# ref, but in a Git repo.
function git_current_branch
    set -l ref (command git symbolic-ref --quiet HEAD 2>/dev/null)
    set -l ret $status
    if test $ret -ne 0
        test $ret -eq 128; and return # no git repo.
        set ref (command git rev-parse --short HEAD 2>/dev/null); or return
    end
    string replace -r '^refs/heads/' '' -- $ref
end
