# Exports
export EDITOR=vim
export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.asdf/shims:$HOME/.cargo/bin/:$HOME/.local/bin:$HOME/go/bin:$PATH

# Plugins
plugins=(
    asdf
    git
    sudo # prefix the current command with "sudo" by pressing Esc twice
    zsh-autosuggestions
    zsh-syntax-highlighting
    copyfile # copies the contents of a file to the clipboard... "copyfile <filename>"
    copybuffer # copies the current text in the cmd line to the clipboard... "ctr+o"
    copypath # copies the absolute path of a given file/dir to the clipboard... "copypath <file/dir>"
)

# Set-up oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set-up FZF
# source <(fzf --zsh) for now FZF version on ubuntu does not support --zsh flag

# ZSH history
HISTFILE=~/.zsh_history
HISTSIZE=1000
HISTTIMEFORMAT="%Y-%m-%d %T "
HISTCONTROL=ignoreboth
SAVEHIST=1000
setopt appendhistory

# Prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/custom.omp.json)"

# Aliases
alias c='clear'
alias ff='fastfetch'
alias vi='$EDITOR'
alias ls='eza --icons=always'
alias lsa='eza -A --icons=always'
alias ll='eza -l --icons=always'
alias lla='eza -lA --icons=always'
alias bat='batcat --theme=ansi'
alias batc='batcat --theme=ansi --paging=never'

# Autostart
if [[ $(tty) == *"pts"* ]]; then
    fastfetch
fi
