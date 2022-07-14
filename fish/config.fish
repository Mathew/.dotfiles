set PATH ~/.config/bin $PATH
set PATH /Users/mathewtaylor/Library/Python/3.9/bin $PATH
set PATH ~/go/bin $PATH

alias vi 'nvim'
alias vim 'nvim'
alias g git
alias s ssh
alias v vim
alias doco docker-compose
alias tx tmux
bind \cs gogo-workspace 


eval (starship init fish)
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths
