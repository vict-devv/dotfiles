# Exports
export EDITOR=vim
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:$HOME/.asdf/shims:$HOME/.cargo/bin/:$HOME/.local/bin:$HOME/go/bin

# Plugins
plugins=(
    git
    sudo
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
    copyfile
    copybuffer
)

# Set-up oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set-up FZF key bindings (CTRL-R for Fuzzy History Finder)
source <(fzf --zsh)

# ZSH history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# Prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/custom.omp.json)"

# Aliases
alias ff='fastfetch'
alias shutdown='systemctl poweroff'
alias vi='$EDITOR'
## scripts
alias cleanup='~/.config/scripts/cleanup.sh'
alias autoremove='~/.config/scripts/autoremove.sh'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# Completions
## asdf
fpath=(${ASDF_DATA_DIRa:-$home/.asdf}/completions $fpath)
autoload -Uz compinit && compinit

# Autostart
## fastfetch
if [[ $(tty) == *"pts"* ]]; then
    fastfetch
fi
