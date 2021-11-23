# Determine the CPU architecture
CPU_ARCH=$(uname -p)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## .zshrc

###### System

export LANG="en_US.UTF-8"
export TERM="xterm-256color"

# Set ulimit
ulimit -n 3000


case ${CPU_ARCH} in
  arm)
    BREW_BASE_PATH="/opt/homebrew"
    ;;
  i386)
    BREW_BASE_PATH="/usr/local"
    ;;
  *)
    BREW_BASE_PATH="/usr/local"
    ;;
esac

###### PATHs and MANPATHs

PATH="${BREW_BASE_PATH}/bin:${PATH}"

# ChefDK
PATH="/opt/chefdk/bin:${PATH}"

# icu4c
PATH="${BREW_BASE_PATH}/opt/icu4c/bin:${PATH}"
PATH="${BREW_BASE_PATH}/opt/icu4c/sbin:${PATH}"

# GNU core utils
PATH="${BREW_BASE_PATH}/opt/coreutils/libexec/gnubin:${PATH}"
MANPATH="${BREW_BASE_PATH}/opt/coreutils/libexec/gnuman:${MANPATH}"

PATH="${BREW_BASE_PATH}/opt/findutils/libexec/gnubin:${PATH}"
MANPATH="${BREW_BASE_PATH}/opt/findutils/libexec/gnuman:${MANPATH}"

PATH="${BREW_BASE_PATH}/opt/gnu-tar/libexec/gnubin:${PATH}"
MANPATH="${BREW_BASE_PATH}/opt/gnu-tar/libexec/gnuman:${MANPATH}"

PATH="${BREW_BASE_PATH}/opt/gnu-sed/libexec/gnubin:${PATH}"
MANPATH="${BREW_BASE_PATH}/opt/gnu-sed/libexec/gnuman:${MANPATH}"

PATH="${BREW_BASE_PATH}/opt/gnu-getopt/bin:${PATH}"

# Python 3.9
PATH="${BREW_BASE_PATH}/opt/python@3.9/bin:${PATH}"
PATH="${BREW_BASE_PATH}/opt/python@3.9/Frameworks/Python.framework/Versions/Current/bin:${PATH}"

# Sphinx Doc
PATH="${BREW_BASE_PATH}/opt/sphinx-doc/bin:${PATH}"

# OpenSSL
PATH="${BREW_BASE_PATH}/opt/openssl@1.1/bin:${PATH}"

# Krew (kubectl plugin manager)
PATH="${PATH}:${HOME}/.krew/bin"

# Ruby Gems
PATH="${HOME}/.gem/ruby/2.3.0/bin:${PATH}"

# Global NPM package configuration
NPM_PACKAGES="${HOME}/.npm-packages"
PATH="${NPM_PACKAGES}/bin:${PATH}"
MANPATH="${NPM_PACKAGES}/share/man:${MANPATH}"


###### Libraries for compilers

# OpenSSL
LDFLAGS="-L${BREW_BASE_PATH}/opt/openssl/lib"
CPPFLAGS="-I${BREW_BASE_PATH}/opt/openssl/include"

# icu4c
LDFLAGS="-L${BREW_BASE_PATH}/opt/icu4c/lib ${LDFLAGS}"
CPPFLAGS="-I${BREW_BASE_PATH}/opt/icu4c/include ${CPPFLAGS}"


###### Exports

export PATH
export LDFLAGS
export CPPFLAGS
export MANPATH

# Go development
export GOPATH="${HOME}/.go"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"
export GOROOT="${BREW_BASE_PATH}/opt/go/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Groovy home
export GROOVY_HOME=${BREW_BASE_PATH}/opt/groovy/libexec

# DSE home
DSE_HOME="${HOME}/dse"

# Makes pipenv create virtual envs in the project's folder instead of ~/.local/share/virtualenvs/
export PIPENV_VENV_IN_PROJECT=true


###### Colors
if command -v dircolors &> /dev/null; then
  if test -f "${HOME}/.dircolors.256dark"; then
    eval $(dircolors "${HOME}/.dircolors.256dark")
  fi
  if ls --color -d . >/dev/null 2>&1; then  # GNU ls
    export COLUMNS  # Remember columns for subprocesses.
    function ls {
      command ls -F -h --color=always -v --author --time-style=long-iso -C "$@" | less -R -X -F
    }
  fi
fi

###### Aliases

alias ll="ls -la"
alias lt="ls -ltr"
alias l="ls -l -a"

# NPM
alias nglob="npm list -g --depth=0 2>/dev/null"
alias nl="npm list --depth=0 2>/dev/null"

# Python
alias python2=python2.7

# Editors
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# Dotfiles repo
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

######  ZSH Configuration
export DEFAULT_USER=$(whoami)

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="powerlevel10k"

# Powerline9k configuration for ZSH
VIRTUAL_ENV_DISABLE_PROMPT=1
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context virtualenv dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs kubecontext time)

# how often to auto-update (in days)
export UPDATE_ZSH_DAYS=7

plugins=(
  macos
  git
  docker
  kubectl
  helm
  httpie
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-nvm
)

# Enable nvm's plugin built in lazy loading
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

# ZSH Autosuggestions config
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true

source ${ZSH}/oh-my-zsh.sh


###### etc

# Simple profiler for measuring the shell’s load time
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# GCP SDK
export CLOUDSDK_PYTHON=${BREW_BASE_PATH}/opt/python@3.8/Frameworks/Python.framework/Versions/3.8/bin/python3.8
export CLOUDSDK_GSUTIL_PYTHON=${BREW_BASE_PATH}/opt/python@3.8/Frameworks/Python.framework/Versions/3.8/bin/python3.8
export CLOUDSDK_BQ_PYTHON=${BREW_BASE_PATH}/opt/python@3.8/Frameworks/Python.framework/Versions/3.8/bin/python3.8
source "${BREW_BASE_PATH}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "${BREW_BASE_PATH}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
