#!/bin/zsh

snow() {
  if (( $# == 0 )); then
    ssh -i ~/.ssh/server snowdenserveripadress

  elif [[ $# = 1 && $1 = 'start' ]]; then
    sudo python3 ~/code/snowdenConfig/start.py

  elif [[ $# = 1 && $1 = 'stop' ]]; then
    gcloud compute instances stop snowden-v2-1 --zone='southamerica-east1-b'

  elif [[ $# = 1 && $1 = 'status' ]]; then
    echo;gcloud compute instances describe snowden-v2-1 --format='get(status)' --zone='southamerica-east1-b'

  fi	
}

source ~/.zsh/jumplist.zsh

alias rld='source ~/.zprofile'
alias l='ls -la'
alias sb='open -a "Sublime Text"' 
alias code='cd ~/code'
alias fcode='open -a "finder" ~/code'
alias p2='python2'
alias p3='python3'
alias lt='cd ~/code/letsCode'
alias op2='open /usr/local/lib/python2.7/site-packages'
alias jn='jupyter notebook'
alias pip='pip3'
alias gli='gcloud compute instances list --format="table(name, networkInterfaces[].ipv6AccessConfigs[0].externalIpv6.notnull().list():label=EXTERNAL_IPV6, status)"'

alias startsnow='~/code/snowdenConfig/start.py'

tmplt() {
  if (( $# == 0 )); then
    cp ~/code/cpe/template/template.cpp template.cpp

  else
    cp ~/code/cpe/template/template.cpp $1

  fi
}

openTrack() {
  open https://us-central1-rooqbiomed.cloudfunctions.net/api/create/$1
}

#alias gtp='f() { git add .; git commit -m "$1."; git push; echo Your arg was $1. };f'
#alias gitp='git add .; git commit; git push'
gitp() {
  if (( $# == 0 )); then
    echo usage: gitp "commit msg"

  else
    git add .
    git commit -m "$1"
    git push origin dev

  fi
}

deploy() {
  if (( $# == 0 )); then
    echo 'usage: deprooq @ "commit msg" | @ = copy from out folder'

  elif [[ $# = 1 && $1 = '@' ]]; then
    echo 'usage: deprooq @ "commit msg" | @ = copy from out folder'

  else
    if [[ $1 == '@' ]]; then
      cp -r ~/rooq/templates/Next-JS-Landing-Page-Starter-Template/out/* ~/rooq/rooq-website-v1
      cd ~/rooq/rooq-website-v1
      cd ~/rooq/rooq-website-v1
      git add ~/rooq/rooq-website-v1
      git commit -m "$2"
      git push
      echo waiting for changes to propagate...
      sleep 8
      open http://rooqbiomed.com

    else
      cd ~/rooq/rooq-website-v1
      git add ~/rooq/rooq-website-v1
      git commit -m "$1"
      git push
      echo waiting for changes to propagate...
      open http://rooqbiomed.com

    fi

  fi
  echo done!
}

alias vim='/usr/local/bin/vim'

v() {
  if (( $# == 0 )); then
    vim ./

  elif [[ $# = 1 ]]; then
    vim ./$1

  fi
}


obi() {
  if (( $# == 1 )); then
    ./$1 < $1.in
  elif [[ $# = 2 ]]; then
    g++ -std=gnu++17 -o $1 $1.cpp && echo '\n---------------\n' && ./$1 < $1.in
  fi
}

export FZF_DEFAULT_COMMAND='rg --files'
export SSH_KEY_PATH="~/.ssh/server"

alias rq='open https://rooqbiomed.com/'
alias op3='open /Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/site-packages'

alias vs='open -a "Visual Studio Code"'

alias simu='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
alias icat='viu'
