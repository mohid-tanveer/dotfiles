# ~/.oh-my-zsh/themes/vintage.zsh-theme

# allow $(…) to be re-evaluated every prompt
setopt prompt_subst

build_prompt() {
  # no spaces around = !
  local userhost="%{$fg_bold[green]%}%n@%m%{$reset_color%}"
  local cwd="%{$fg_bold[magenta]%}%~%{$reset_color%}"
  local branch=""
  local dirty=""

  # git status?
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      dirty="*"
    fi
    branch="%{$fg_bold[yellow]%}git(${branch_name})${dirty}%{$reset_color%}"
  fi

  printf "%-15s %-15s %s" "$userhost" "$cwd" "$branch"
}

# two-line prompt: info above, then a lone $
PROMPT=$'%{$reset_color%}$(build_prompt)\n$ '
