ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_CLEAN_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_DIRTY_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_REV_COLOUR="%{$fg[yellow]%}"

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(current_branch)
  local cr=$(current_rev)
  if [ -n "$cb" ]; then
    local dirty=$(parse_git_dirty)
    local prompt=""
    zsh_theme_git_prompt_prefix=$ZSH_THEME_GIT_PROMPT_CLEAN_PREFIX
    if [ -n "$dirty" ]; then
      zsh_theme_git_prompt_prefix=$ZSH_THEME_GIT_PROMPT_DIRTY_PREFIX
    fi
    prompt="$zsh_theme_git_prompt_prefix$(current_branch)$ZSH_THEME_GIT_PROMPT_REV_COLOUR@$(current_rev)$ZSH_THEME_GIT_PROMPT_DIRTY_SUFFIX"
    echo " $ZSH_THEME_GIT_PROMPT_PREFIX$prompt$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

virtual_env_status() {
  if [ -n "$VIRTUAL_ENV" ]; then
    local ve=$(basename `echo $VIRTUAL_ENV`)
    echo "%{$fg[yellow]%}$ve %{$reset_color%}"
  fi
}

prompt_time() {
  echo "%{$FG[237]%}%D{%H%M}%{$reset_color%}"
}

PROMPT='$(prompt_time) $(virtual_env_status)${${PWD}/$HOME/~}$(git_custom_status) »%b '