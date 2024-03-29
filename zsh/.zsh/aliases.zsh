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
alias l='ls --color=none'
alias la='ls -al'

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
