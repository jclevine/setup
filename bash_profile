function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
    }

PS1="\n\n\e[0;36m\$(parse_git_branch)\e[m\n[\e[0;32m\w\e[m]\n\n\$ "
export LS_COLORS="di=36:ln=36;1:ex=31;1:*~=31;1:*.html=31;1:*.shtml=37;1:*.java=33"

export EDITOR="/c/bin/gvim.exe"
export VIM="/c/Program Files (x86)/Vim/vim74"
alias ll='ls -la --color=auto'
alias ls='ls --color=auto'
alias vim='/c/Program\ Files\ \(x86\)/Vim/vim74/gvim.exe'

eval `ssh-agent`
ssh-add
cd /c/_src/orca/orca

