HISTCONTROL=ignoreboth
HISTSIZE=5000
source /usr/local/bin/virtualenvwrapper.sh
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:usr/local/lib:$PATH

export EDITOR='vim'

alias vi='vim'
alias g=git
alias s=ssh
alias v=vim
alias va=vagrant
alias tx=tmux
alias txr=tmuxinator
alias doco=docker-compose

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
