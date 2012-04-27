alias vi='mvim'
alias vim='mvim'
alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
HISTCONTROL=ignoreboth
HISTSIZE=5000
export EDITOR='mvim -f --nomru -c "au VimLeave * !open -a iTerm"'
export VISUAL='mvim -f'
source /usr/local/bin/virtualenvwrapper.sh
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH
