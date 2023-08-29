dir_stack=("$PWD")
stack_pos=1

function cd {
    local b="$PWD"
    if [[ -z "$1" ]]; then
        builtin cd ~
    else
        builtin cd "$1"
    fi
    local a="$PWD"

    if [[ "$a" != "$b" ]]; then
        dir_stack=("${dir_stack[@]:0:$stack_pos+1}" "$a")
        stack_pos=$(( stack_pos + 1 ))
    fi
}

function b {
  if (( stack_pos > 1 )); then
    stack_pos=$(( stack_pos - 1 ))
    builtin cd ${dir_stack[stack_pos]}
  fi
}


function f {
  if (( stack_pos < ${#dir_stack[@]} )); then
    stack_pos=$(( stack_pos + 1 ))
    builtin cd ${dir_stack[stack_pos]}
  fi
}

function press_b {
  BUFFER="b"
  zle accept-line
}

zle -N press_b
#bindkey "^O" press_b

function press_f {
  BUFFER="f"
  zle accept-line
}

zle -N press_f
#bindkey "^M" press_f
