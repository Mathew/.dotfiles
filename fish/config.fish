set PATH ~/.config/bin $PATH
set PATH ~/go/bin $PATH
set PATH ~/.local/bin $PATH

eval "$(/opt/homebrew/bin/brew shellenv)"

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

source /Users/mat/.docker/init-fish.sh || true # Added by Docker Desktop
