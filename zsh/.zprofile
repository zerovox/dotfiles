#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# PATH
if [[ -s "$HOME/Library/pnpm" ]]; then
  path=("$HOME/Library/pnpm" $path)
fi

if [[ -s "$HOME/.cargo/bin" ]]; then
  path=("$HOME/.cargo/bin" $path)
fi

if [[ -s "$GOPATH/bin" ]]; then
  path=("$GOPATH/bin" $path)
fi

if [[ -s "/opt/homebrew/bin" ]]; then
  path=("/opt/homebrew/bin" "/opt/homebrew/sbin" $path)
fi

if [[ -s "$HOME/.local/bin" ]]; then
  path=("$HOME/.local/bin" $path)
fi

if [[ -s "$HOME/.local/bin/utils" ]]; then
  path=("$HOME/.local/bin/utils" $path)
fi

if [[ -s "$HOME/.bin" ]]; then
  path=("$HOME/.bin" $path)
fi

export PATH
