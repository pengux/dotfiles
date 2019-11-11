# Env vars
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$HOME/.local/bin:$PATH

# 10ms for key sequences
KEYTIMEOUT=1
setopt histignoredups
setopt histignorespace
setopt menucomplete

source ~/.zplug/init.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/gitfast", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-autosuggestions"
zplug load --verbose

# use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
# zsh-autosuggestions is designed to be unobtrusive)
bindkey '^X' autosuggest-execute
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'
# Accept suggestions without leaving insert mode
bindkey '^f' vi-forward-word
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor}/*" 2> /dev/null'

alias ls="ls -lah"

# Git aliases
alias ga='git add'
alias gb='git branch'
alias gc='git commit -v'
alias gd='git diff'
alias glog='git log --oneline --decorate --graph'
alias gp='git push'
alias gsta='git stash push'
alias gstp='git stash pop'

# Manage dotfiles with git bare repository
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
