# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# docker ps --format=$FORMAT
# or docker container ls --format=#FORMAT
DPS_FORMAT="\nID\t{{.ID}}\nIMAGE\t{{.Image}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.RunningFor}}\nSTATUS\t{{.Status}}\nPORTS\t{{.Ports}}\nNAMES\t{{.Names}}\n"


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# https://unix.stackexchange.com/questions/90853/how-can-i-run-ssh-add-automatically-without-a-password-prompt
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add ~/.ssh/id_ed25519_w11
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-completions
  # zsh-syntax-highlighting
  fzf
  # zsh-interactive-cd
  safe-paste
  last-working-dir
  extract
  colored-man-pages
#   ssh-agent
#   docker
#   minikube
#   virtualenv
  )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# https://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
function expand-alias() {
	zle _expand_alias
  zle expand-word
	# zle self-insert
}
zle -N expand-alias
bindkey -M main '^ ' expand-alias

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M viins '^[OH' beginning-of-line  # Home
bindkey -M viins '^[OF' end-of-line  # End
bindkey -M viins '^a' beginning-of-line  # Home
bindkey -M viins '^e' end-of-line  # End
bindkey -M viins '^[[Z' autosuggest-accept  # shift + tab  | accept entire line

# built in bindings
# https://help.gnome.org/users/gnome-terminal/stable/adv-keyboard-shortcuts.html.en
bindkey '^f' forward-word  # ctrl+f  | right arrow
bindkey '^b' backward-word  # ctrl+b  | left arrow
bindkey '^k' kill-line  # ctrl+k  | Delete from the cursor to the end of the line
bindkey '^p' up-line-or-history
bindkey '^n' down-line-or-history

# bindkey '^y' yank  # not working
# bindkey '^_' backward-delete-char  # ctrl+/  | undo previous key
# /-Shift-Ctrl = Bksp      = '^?'
# ctrl+p       = Up         | previous command
# ctrl+h       = Bksp       | backward-delete-char
# Ctrl+[       = Esc        | vi-cmd-mode
# Ctrl+g       = Esc        | exit menu
# Ctrl+z       | send process to background, fg <prior cmd> to foreground
# bindkey '^I' complete-word       # tab          | complete
# Command list to bind: https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# https://github.com/junegunn/fzf
# Customize how fzf handles certain commands 
_fzf_comprun() { 
  local command=$1 
  shift 

  case "$command" in
    bat) fzf "$@" --preview 'batcat --style=numbers --color=always --line-range :50 {}'   --bind shift-up:preview-page-up,shift-down:preview-page-down ;; 
    batcat) fzf "$@" --preview 'batcat --style=numbers --color=always --line-range :50 {}'   --bind shift-up:preview-page-up,shift-down:preview-page-down ;; 
    cat) fzf "$@" --preview 'batcat --style=numbers --color=always --line-range :50 {}'   --bind shift-up:preview-page-up,shift-down:preview-page-down ;; 
    cd) fzf "$@" --preview 'tree -C {} | head -20'  --bind shift-up:preview-page-up,shift-down:preview-page-down ;; 
    code) fzf "$@" --preview 'batcat --style=numbers --color=always --line-range :50 {}'   --bind shift-up:preview-page-up,shift-down:preview-page-down ;; 
    ls) fzf "$@" --preview 'tree -C {} | head -200'  --bind shift-up:preview-page-up,shift-down:preview-page-down ;;
    source) fzf "$@" --preview 'batcat --style=numbers --color=always --line-range :50 {}'   --bind shift-up:preview-page-up,shift-down:preview-page-down ;;  
    *) fzf "$@" ;; 
  esac 
} 

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias setclip="xclip -selection c"
# alias getclip="xclip -selection c -o"
# https://ostechnix.com/bat-a-cat-clone-with-syntax-highlighting-and-git-integration/
alias bat='batcat'
# alias k="kubectl"
# source <(kubectl completion zsh)

alias fd=fdfind
# https://bluz71.github.io/2018/11/26/fuzzy-finding-in-bash-with-fzf.html
# Ctrl+r  | paste from history
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# Ctrl+t  | paste path of files and folder
export FZF_CTRL_T_OPTS="--preview 'batcat --color=always --line-range :500 {}'"
# Alt+c  | cd to specific directory
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion