function parse_git_branch {
  branch_name=$(git symbolic-ref HEAD 2> /dev/null) || return
  files_changed_count=$(git status -s --column=plain 2> /dev/null | wc -l)

  short_status=$(git status -sb) 2> /dev/null || ''
  status_with_changed_files=${short_status#*[}

  echo "("${branch_name#refs/heads/}\)"" [${files_changed_count} files changed ]""
}

PS1="\n\n\e[0;36m\$(parse_git_branch)\e[m\n[\e[0;32m\w\e[m]\n\n\$ "
#PS1="\n[\e[0;32m\w\e[m]\n\n\$ "
export LS_COLORS="di=36:ln=36;1:ex=31;1:*~=31;1:*.html=31;1:*.shtml=37;1:*.java=33"

alias ll='ls -la -G'
alias ls='ls -G'

# SSH
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# Add bash completion
source ~/bin/git-completion.bash

# Add NVM
export NVM_DIR=~/.nvm
. $(brew --prefix nvm)/nvm.sh

# Added by Dato Launcher v2.2.0
export PATH="/Users/jlevine/anaconda/bin:$PATH"

# CF completion
complete -C cf_completion cf

# Set Java Home
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# Port user alias
alias netstatano="netstat -vanp tcp | grep $0"
