# edit and source profiles
alias src="source $HOME/.zshrc"

# git
alias g=git

# maven
alias mc='mvn clean test'
alias mcs='mvn clean install -DskipTests=true'
alias mci='mcs -T1C'
alias mcis='mci -Psystem'
alias mciall='mci -U -DdownloadSources=true'

# ls
alias ll='ls -l'
alias l='ls -CF'
alias la='ls -al'

# bazel
alias b='bazel'
alias bb='bazel build'
alias br='bazel run'
alias bt='bazel test --test_output=all'
alias bq='bazel query'

# pretty print
alias prettyjson='python -m json.tool'

# vim
alias vim='nvim'

# less
alias less='less -R'

# grep
alias grep='grep --color=auto'

# cd
alias ..='cd ../'
