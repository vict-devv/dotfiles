# Exports
export EDITOR=vim
export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.asdf/shims:$HOME/.local/bin:$PATH

plugins=(
    asdf
    copybuffer # copies the current text in the terminal to clipboard `Ctrl+O`
    copyfile # copies the contents of a file to clipboard `copyfile <filename>`
    copypath # copies the absolute path of a file/dir to clipboard `copypath <file/dir>`
    fzf
    git
    sudo # prefix the command with "sudo" by pressing Esc twice
    kubectl
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Oh My ZSH
source $ZSH/oh-my-zsh.sh

# Starship Prompt
eval "$(starship init zsh)"

# Tmux
#if [[ -z "$TMUX" ]]; then
#    tmux attach-session -t default || tmux new-session -s default
#fi

# Aliases
alias c='clear'
alias ff='fastfetch'
alias vi='$EDITOR'
alias ls='eza --icons=always'
alias lsa='eza -A --icons=always'
alias ll='eza -l --icons=always'
alias lla='eza -lA --icons=always'
alias cat='bat --theme=ansi'
alias catc='bat --theme=ansi --paging=never'
