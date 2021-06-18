#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export GOPATH=$HOME/go
export TSC_NONPOLLING_WATCHER=true
export NODE_TLS_REJECT_UNAUTHORIZED="0"

if [[ -s "/usr/libexec/java_home" ]]; then
  # JAVA_HOME
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

# PATH
if [[ -s "$YARN_GLOBAL" ]]; then
  export PATH="$YARN_GLOBAL/node_modules/.bin/:$PATH"
fi

if [[ -s "$HOME/.bin" ]]; then
  export PATH="$HOME/.bin:$PATH"
fi

if [[ -s "$GOPATH/bin" ]]; then
  export PATH="$GOPATH/bin:$PATH"
fi

if [[ -s "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [[ -s "$NVM_DIR" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
fi


