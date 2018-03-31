# DevEnvSetup

# Git tips
git rev-parse --show-toplevel

git config --global --add alias.root '!pwd'

https://stackoverflow.com/questions/957928/is-there-a-way-to-get-the-git-root-directory-in-one-command


# Bash Command Prompt
USER='\033[01;32m\]'$USER
HOST=' \033[02;36m\]\h'
parseGitBranch () { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'; }
TIME='\033[01;31m\]\t \033[01;32m\]'
LOCATION=' \033[01;34m\]`pwd | sed "s#\(/[^/]\{1,\}/[^/]\{1,\}/[^/]\{1,\}/\).*\(/[^/]\{1,\}/[^/]\{1,\}\)/\{0,1\}#\1_\2#g"`'
BRANCH=' \033[00;33m\]$(parseGitBranch)\[\033[01;38;5;200m\]\n=>\[\033[00m\] '
PS1=$USER$HOST$LOCATION$BRANCH
