#!/bin/zsh

echo '\n\n# aliases
alias ..="cd .."
alias cm="git commit -m"
alias cm-a="git add . && git commit -m"
alias a="git add"
alias ps="git push"
alias pl="git pull"
alias s="git status"
alias cb="git checkout"
alias nb="git checkout -b"
alias db="git branch -D"
alias cl="git clone"' >> ~/.zshrc