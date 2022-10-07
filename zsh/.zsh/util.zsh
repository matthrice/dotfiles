# Rebase onto latest upstream changes
rbb ()
{
    local stash_size
    local target_branch
    stash_size="$(git stash list | wc -l)"
    git stash;
    target_branch="$(get_current_branch)"
    git checkout "$(get_head_git_branch)"
    git pull --rebase;
    git checkout "$target_branch";
    git rebase "$(get_head_git_branch)";
    if [[ $(git stash list | wc -l) != "$stash_size" ]]; then
    git stash pop;
    fi
}

