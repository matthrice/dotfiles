# Get the head branch (Gerrit)
get_head_git_branch ()
{
    git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
}

# Get the current branch
get_current_branch ()
{
    git rev-parse --abbrev-ref HEAD
}

# Create a new branch with correct (Gerrit) upstream
gnb ()
{
    local stash_size=$(git stash list | wc -l);
    local current_branch=$(get_current_branch);
    git stash;
    git checkout -b "$1";
    git branch -u origin/$(get_head_git_branch);
    if [[ $(git stash list | wc -l) != $stash_size ]]; then
    git stash pop;
    fi
}

# Rebase onto latest upstream changes
rbb ()
{
    local stash_size=$(git stash list | wc -l);
    git stash;
    local target_branch=$(get_current_branch);
    git checkout $(get_head_git_branch);
    git pull --rebase;
    git checkout $target_branch;
    git rebase $(get_head_git_branch);
    if [[ $(git stash list | wc -l) != $stash_size ]]; then
    git stash pop;
    fi
}

