parse_git_branch() {
  local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [[ $branch != "" ]]; then
    echo \[$branch\]
  fi
}
setopt PROMPT_SUBST
autoload -U colors && colors

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux: blue for path and username
  prompt='
╭─ %{$fg_bold[blue]%}%~%{$reset_color%} %{$fg_bold[magenta]%}%{$(parse_git_branch)%}%{$reset_color%} %{$fg_bold[yellow]%}❯%{$reset_color%} %{$fg_bold[blue]%}${(U)USER}%{$reset_color%} %{$fg_bold[red]%}%*%{$reset_color%}
╰─❯ '
else
  # Mac: check username
  if [[ "${USER}" == "fox" ]]; then
    # Green for fox user
    PROMPT='
╭─ %{$fg_bold[green]%}%~%{$reset_color%} %{$fg_bold[magenta]%}%{$(parse_git_branch)%}%{$reset_color%} %{$fg_bold[yellow]%}❯%{$reset_color%} %{$fg_bold[green]%}${(U)USER}%{$reset_color%} %{$fg_bold[red]%}%*%{$reset_color%}
╰─❯ '
  else
    # Orange for other users with bold
    PROMPT='
╭─ %B%F{214}%~%f%b %{$fg_bold[magenta]%}%{$(parse_git_branch)%}%{$reset_color%} %{$fg_bold[yellow]%}❯%{$reset_color%} %B%F{214}${(U)USER}%f%b %{$fg_bold[red]%}%*%{$reset_color%}
╰─❯ '
  fi
fi
