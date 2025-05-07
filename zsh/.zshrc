# imports

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bind Ctrl-R to fuzzy‐search shell history
bindkey '^R' fzf-history-widget

# bind Ctrl-T to fuzzy‐search files in the current directory
bindkey '^T' fzf-file-widget

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# thefuck
eval "$(thefuck --alias)"

# direnv
export DIRENV_LOG_FORMAT=""
eval "$(direnv hook zsh)"

# disable underlining of paths, commands, etc.
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow'               # your paths stay yellow, no underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[directory]='fg=cyan'           # full dirs if you like them different
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=magenta' # keep the normal colour
ZSH_HIGHLIGHT_STYLES[command]='fg=green'             # co stay green
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'          # sudo stays green
ZSH_HIGHLIGHT_STYLES[unknown]='fg=red' 
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=green'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green'

# use nvim
export SUDO_EDITOR=$(which nvim)
export VISUAL=$(which nvim)
export EDITOR=$(which nvim)

# path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# use qt5ct
export QT_QPA_PLATFORMTHEME="qt5ct"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="mtanveer"

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
  direnv
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
alias vi="nvim"
alias svi="sudo nvim"
alias svim="sudo nvim"
alias sdi="sudo dnf install"
alias sdu="sudo dnf update"
alias sdr="sudo dnf remove"
alias sds="sudo dnf search"
