# Get the head branch
function get_head_git_branch ()
{
    git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
}

# Get the current branch
function get_current_branch ()
{
    git rev-parse --abbrev-ref HEAD
}

# Rebase onto latest upstream changes
function rbb ()
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

# SSH with tmux
function tsh()
{
    local host="${1}"

    # copy ssh key if required
    if ! ssh -q -o "BatchMode=yes" "${host}" exit; then
        ssh-copy-id "${host}"
    fi

    ssh -X -t "${USER}@${host}" '
        if [ ! -d "${HOME}/.dotfiles" ]; then
            git clone https://github.com/matthrice/dotfiles.git "${HOME}/.dotfiles"
            "${HOME}/.dotfiles/basic_bash_install.sh"
        fi

        tmux -CC new -A -s "${USER}"
    '
}
