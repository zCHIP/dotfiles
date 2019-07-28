export LANG="en_US.UTF-8"

# Set ulimit
ulimit -n 3000

# Adds SSH key
ssh-add ~/.ssh/temnikov_id_rsa 2>/dev/null

######

PATH="${HOME}/bin:/usr/local/sbin:${PATH}"
PATH="/usr/local/bin:${PATH}"

PATH="/opt/chefdk/bin:${PATH}"
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"

# icu4c
PATH="/usr/local/opt/icu4c/bin:${PATH}"
PATH="/usr/local/opt/icu4c/sbin:${PATH}"

# GNU core utils
PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"

PATH="/usr/local/opt/findutils/libexec/gnubin:${PATH}"
MANPATH="/usr/local/opt/findutils/libexec/gnuman:${MANPATH}"

PATH="/usr/local/opt/gnu-tar/libexec/gnubin:${PATH}"
MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:${MANPATH}"

PATH="/usr/local/opt/gnu-sed/libexec/gnubin:${PATH}"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:${MANPATH}"

PATH="/usr/local/opt/gnu-getopt/bin:${PATH}"

######

# OpenSSL libraries for compilers
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

# export LDFLAGS="-L/usr/local/opt/icu4c/lib"
# export CPPFLAGS="-I/usr/local/opt/icu4c/include"

######

# Global NPM package configuration
NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"

# Go development
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

# Groovy home
export GROOVY_HOME=/usr/local/opt/groovy/libexec

# Ruby Gems
PATH="${HOME}/.gem/ruby/2.3.0/bin:${PATH}"

# DSE home
DSE_HOME="${HOME}/dse"

# Makes pipenv create virtual envs in the project's folder instead of ~/.local/share/virtualenvs/
export PIPENV_VENV_IN_PROJECT=true

# Man
export MANPATH="$NPM_PACKAGES/share/man:${MANPATH}"
export PATH

### Aliases
eval "$(dircolors)"

if ls --color -d . >/dev/null 2>&1; then  # GNU ls
  export COLUMNS  # Remember columns for subprocesses.
  eval "$(dircolors)"
  function ls {
    command ls -F -h --color=always -v --author --time-style=long-iso -C "$@" | less -R -X -F
  }
  alias ll="ls -la"
  alias lt="ls -ltr"
  alias l="ls -l -a"
fi

alias ng="npm list -g --depth=0 2>/dev/null"
alias nl="npm list --depth=0 2>/dev/null"
alias python2=python2.7
alias lzd="lazydocker"

### ZSH Configuration

export DEFAULT_USER=`whoami`

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="powerlevel9k"

# ZSH Theme Powerline9k configuration
VIRTUAL_ENV_DISABLE_PROMPT=1
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context virtualenv dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs kubecontext time)

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

plugins=(
  osx
  git
  pipenv
  zsh-autosuggestions
  zsh-nvm
)

# ZSH Autosuggestions config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true

source ${ZSH}/oh-my-zsh.sh


#export KITCHENLIB_SSH_KEY=~/.ssh/temnikov_id_rsa KITCHENLIB_USERNAME=yh00676

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/temnikovgennadiy/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/temnikovgennadiy/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/temnikovgennadiy/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/temnikovgennadiy/google-cloud-sdk/completion.zsh.inc'; fi

# Syntax highlight
if [ -f '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]; then
  source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
fi
