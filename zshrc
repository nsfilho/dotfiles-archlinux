export ZSH="$HOME/.oh-my-zsh"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

plugins=(zsh-interactive-cd history-substring-search zsh-autosuggestions zsh-syntax-highlighting git)

source $ZSH/oh-my-zsh.sh
source <(/usr/bin/starship init zsh --print-full-init)
source $HOME/.cargo/env
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

export EDITOR=nvim
alias cat="bat"
alias ls="exa --icons"
alias vi="nvim"
alias vim="nvim"
alias pacman="sudo pacman"
alias zlocal="nvim ~/.zshrc"
alias ssh="kitty +kitten ssh"
alias interno="ssh -p 4522 root@minhacasa.e01aio.com.br"
alias servidor8="ssh root@servidor8.usign.io"
alias servidor9="ssh root@servidor9.usign.io"
alias servidor10="ssh root@servidor10.usign.io"
alias servidor11="ssh root@servidor11.usign.io"
alias servidor12="ssh root@servidor12.usign.io"
alias servidor13="ssh root@servidor13.usign.io"
alias servidor14="ssh root@servidor14.usign.io"
alias servidor15="ssh root@servidor15.usign.io"
alias servidor16="ssh root@servidor16.usign.io"
alias servidor17="ssh root@servidor17.usign.io"
alias vtruqa="ssh admin@server-qa.vtru.dev"
alias proxy1="ssh root@proxy1.jbtec.com.br"
alias zabbix="ssh root@zabbix.jbtec.com.br"

function updateArch() {
    sudo pacman -Syu
    fix_discord.sh
}
