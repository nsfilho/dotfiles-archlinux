#!/bin/bash

source utils.sh

# Preparing git
function gitAlias()
{
    aliasToCheck=$1
    content=$2
    echo -n "Checking git alias [$aliasToCheck]: "
    if [ x"`git config --get alias.$aliasToCheck`" = x ] ; then
        echo "setting done!"
        git config --global alias.$aliasToCheck "$content"
    else
        echo "already configured."
    fi
}

gitAlias "lg" "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
gitAlias "apply-gitignore" '!git ls-files -ci --exclude-standard -z | xargs -0 git rm --cached'
gitAlias "slog" "log --pretty=oneline --abbrev-commit"
gitAlias "ap" "add --patch"
git config --global push.followTags true
git config --global merge.ff true
