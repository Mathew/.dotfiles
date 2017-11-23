function prompt_char {
    if [ $UID -eq 0 ]; then echo "#"; else echo ❯; fi
}

prompt_pure_precmd() {
        # shows the full path in the title
        print -Pn '\e]0;%~\a'

        # reset value since `preexec` isn't always triggered
        unset cmd_timestamp
}

#PROMPT='%{$fg_bold[blue]%}%(!.~.%~) $(git_prompt_info)%_$(prompt_char)%{$reset_color%} '
PROMPT='%{$fg_bold[blue]%} %_$(prompt_char)%{$reset_color%} '
RPROMPT='% $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_no_bold[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_no_bold[green]%}✔%{$reset_color%}"

