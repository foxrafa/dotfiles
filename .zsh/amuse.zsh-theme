parse_git_branch() {
  local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

  if [[ $branch != "" ]]; then
    echo \[$branch\]
  fi
}

setopt PROMPT_SUBST
autoload -U colors && colors
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  prompt='
╭─ %{$fg_bold[cyan]%}%~%{$reset_color%} %{$fg_bold[magenta]%}%{$(parse_git_branch)%}%{$reset_color%} %{$fg_bold[yellow]%}❯%{$reset_color%} %{$fg_bold[cyan]%}FOX%{$reset_color%} %{$fg_bold[red]%}%*%{$reset_color%}
╰─❯ '
else
  PROMPT='
╭─ %{$fg_bold[green]%}%~%{$reset_color%} %{$fg_bold[magenta]%}%{$(parse_git_branch)%}%{$reset_color%} %{$fg_bold[yellow]%}❯%{$reset_color%} %{$fg_bold[green]%}FOX%{$reset_color%} %{$fg_bold[red]%}%*%{$reset_color%}
╰─❯ '
fi
