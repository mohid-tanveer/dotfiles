# bootstrap

# homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# clone oh-my-zsh if missing
if [[ ! -d $ZSH ]]; then
  echo "oh-my-zsh is missing\n installing oh-my-zsh…"
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$ZSH"
fi

# clone p10k theme
if [[ ! -d $ZSH_CUSTOM/themes/powerlevel10k ]]; then
  echo "p10k is missing\n installing p10k theme…"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# clone zsh-autosuggestions
if [[ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]]; then
  echo "zsh-autosuggestions is missing\n installing zsh-autosuggestions…"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# clone zsh-syntax-highlighting
if [[ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]]; then
  echo "zsh-syntax-highlighting is missing\n installing zsh-syntax-highlighting…"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# detect OS for package hints
if [[ "$OSTYPE" == darwin* ]]; then
  pkg_mgr="brew install"
elif [[ -f /etc/fedora-release ]]; then
  pkg_mgr="sudo dnf install"
else
  pkg_mgr="install"
fi

# display hint for other packages
for cmd in thefuck fzf pyenv zoxide node poetry; do
  if ! command -v $cmd >/dev/null 2>&1; then
    case $cmd in
      thefuck)
        hint="$pkg_mgr thefuck"
        ;;
      fzf)
        hint="$pkg_mgr fzf && \$(fzf)/install"
        ;;
      pyenv)
        hint="$pkg_mgr pyenv && follow next steps"
        ;;
      zoxide)
        hint="$pkg_mgr zoxide && follow next steps"
        ;;
      node)
        hint="$pkg_mgr node"
        ;;
      poetry)
        hint="$pkg_mgr poetry"
        ;;
      *)
        hint="$pkg_mgr $cmd"
        ;;
    esac
    echo "WARNING: '$cmd' not found. To install, run: $hint"
    echo "	Once installed, verify with: $cmd --version"
  fi
done

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# imports

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bind Ctrl-R to fuzzy‐search shell history
bindkey '^R' fzf-history-widget

# bind Ctrl-T to fuzzy‐search files in the current directory
bindkey '^T' fzf-file-widget

# thefuck
eval "$(thefuck --alias)"

# disable underlining of paths, commands, etc.
typeset -A ZSH_HIGHLIGHT_STYLES

typeset -gA ZSH_HIGHLIGHT_STYLES=(
  path                            'fg=93'
  path_pathseparator              'fg=93'
  path_prefix                     'fg=93'
  path_prefix_pathseparator       'fg=93'
  directory                       'fg=93'
  autodirectory                   'fg=93'
  history-expansion               'fg=magenta'
  command                         'fg=green'
  precommand                      'fg=green'
  unknown                         'fg=red'
  suffix-alias                    'fg=green'
  dollar-quoted-argument          'fg=105'
  back-quoted-argument            'fg=105'
  back-double-quoted-argument     'fg=105'
  back-dollar-quoted-argument     'fg=105'
  dollar-double-quoted-argument   'fg=105'
  command-substitution            'fg=105'
  process-substitution            'fg=105'
  double-hyphen-option            'fg=105'
  single-hyphen-option            'fg=105'
  double-quoted-argument          'fg=105'
  single-quoted-argument          'fg=105'
)

# use nvim
export SUDO_EDITOR=$(which nvim)
export VISUAL=$(which nvim)
export EDITOR=$(which nvim)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# uncomment the following line to use hyphen-insensitive completion.
# case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# which plugins would you like to load?
# standard plugins can be found in $ZSH/plugins/
# custom plugins may be added to $ZSH_CUSTOM/plugins/
# example format: plugins=(rails git textmate ruby lighthouse)
# add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  gitfast
  git-auto-fetch
  zsh-syntax-highlighting
  zsh-autosuggestions
  fzf
  zoxide
  node
  npm
  pyenv
  pip
  poetry
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# for a full list of active aliases, run `alias`.
#
# aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias p10kconfig="nvim ~/.p10k.zsh"
alias kittyconfig="nvim ~/.config/kitty/kitty.conf"
alias nvimconfig="nvim ~/.config/nvim/init.lua"
alias vi="nvim"
alias svi="sudo nvim"
alias svim="sudo nvim"
alias sdi="sudo dnf install"
alias sdu="sudo dnf update"
alias sdr="sudo dnf remove"
alias sds="sudo dnf search"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:/Users/mohidtanveer/.spicetify
