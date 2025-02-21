#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

HISTSIZE=100000
SAVEHIST=100000
REPORTTIME=10
# ALIASES
alias hlog='git log --date-order --all --graph --format="%C(green)%h %Creset%C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset %s"'
alias olog='git log origin/`git rev-parse --abbrev-ref HEAD` --date-order --graph --format="%C(green)%h %Creset%C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset %s"'

alias ag='rg'
alias y='yarn'
alias yb='yarn build'
alias yl='yarn lint'
alias yf='yarn lint --fix'
alias ts='ts "[%Y-%m-%d %H:%M:%.S]"'
alias gpu='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gcb='git checkout -b'
alias gcr='git checkout -b $(tslatcher-branch-name-generator)'
alias grr='git fetch && git add . && git stash && git checkout origin/develop && gcr && git stash pop'
alias gsr='git add . && git stash && git checkout origin/develop && gcr && git stash pop'
alias gsdc='git add . && git stash && git checkout origin/develop-cached && gcr && git stash pop && git add .'
alias gdl='git branch -D `git branch | grep -v \* | xargs`'
alias gcdd='git checkout develop'
alias gcd='git checkout origin/develop'
alias gcdc='git checkout origin/develop-cached'
alias ...="cd ../../"
alias ....="cd ../../../"
alias wgc='./node_modules/.bin/wizard generate changelog'
alias tls='tree -shL 1'
alias hint='less ~/.tmux-hints'
alias rsync='rsync --stats --progress'
alias note='touch ~/Notes/$(date +%F).txt && idea ~/Notes/$(date +%F).txt'
alias ynote='touch ~/Notes/$(date -v-1d +%F).txt && idea ~/Notes/$(date -v-1d +%F).txt'
alias wnote='touch ~/Notes/weekly-$(gdate -d last-monday +%F).txt && idea ~/Notes/weekly-$(gdate -d last-monday +%F).txt'
alias notes='idea ~/Notes/'
alias h='eval "$(history -1000 | cut -c 8- | fzf)"'

function gac {
  git diff --cached | llm 'Write a short plain text commit message for the following diff. It should have a single short message title, and additional bullets in the message body if relevant. Do not detail all technical changes, focus on the intention of the change. Removed TODOs may give hints to the indicate then intention of the changes. Return only the message, do not wrap the response in ticks. Avoid words like enhance and improve.' --no-stream > /tmp/gac.txt

  vi /tmp/gac.txt

  git commit -F /tmp/gac.txt

  rm -f /tmp/gac.txt
}

[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

function f {
  find -L . -name *$1* -print
}

function movtogif() {
  rm /tmp/palette.png
  ffmpeg -i "$1" -vf "fps=10,scale=-1:-1:flags=lanczos,palettegen" -y /tmp/palette.png
  ffmpeg -i "$1" -i /tmp/palette.png -lavfi "fps=10,scale=-1:-1:flags=lanczos [x]; [x][1:v] paletteuse" -y "${1%.*}.gif"
}

if [[ -s ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
    if command -v fzf &> /dev/null
    then
        # If we found fzf, rebind fasd alias to use fzf
        unalias j
        function j {
          cd $(fasd -l -R $1 | fzf)
        }
    fi
fi

# Source local additions
if [[ -s ~/.zshrc-local ]]; then
  source ~/.zshrc-local
fi
