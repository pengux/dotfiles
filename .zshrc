# PATH
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.gem/ruby/2.7.0/bin:$PATH:$HOME/.emacs.d/bin

export EDITOR=nvim
export VISUAL=nvim
export BROWSER=waterfox-g4

# Wayland
export QT_QPA_PLATFORM=wayland-egl
export CLUTTER_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1
export XDG_CURRENT_DESKTOP=sway

# GPG
export GPG_TTY=$(tty)

# Chrome
export CHROME_EXECUTABLE=google-chrome-stable

# Android SDK
export ANDROID_HOME=$HOME/Android/Sdk

# 10ms for key sequences
KEYTIMEOUT=1
setopt histignoredups
setopt histignorespace
setopt sharehistory
setopt menucomplete
HISTFILE=~/.zshhistory
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

source ~/.zplug/init.zsh
zplug "plugins/gitfast", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "junegunn/fzf", use:"shell/*.zsh", defer:2
zplug "agkozak/zsh-z"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug load

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
alias gst='git status'
alias gcl='git clone'
alias gco='git checkout'
alias gup='git pull --rebase'

# Manage dotfiles with git bare repository
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Generate password
alias newpass="head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-' | fold -w 32 | head -n 1"

# K8s alias
alias k='kubectl'

# Prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
# PROMPT=\$vcs_info_msg_0_'%# '
zstyle ':vcs_info:git:*' formats '%b'

# added by travis gem
[ -f /home/peter/.travis/travis.sh ] && source /home/peter/.travis/travis.sh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion

PATH="/home/peter/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/peter/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/peter/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/peter/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/peter/perl5"; export PERL_MM_OPT;

source ~/.zsh_conf/*

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

