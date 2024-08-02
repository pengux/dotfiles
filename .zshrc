# PATH
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.gem/ruby/2.7.0/bin:$PATH:$HOME/.emacs.d/bin

export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox

# Wayland
export QT_QPA_PLATFORM=wayland-egl
export CLUTTER_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1
export XDG_CURRENT_DESKTOP=sway

# Bat theme
export BAT_THEME="base16"

# GPG
export GPG_TTY=$(tty)

# Chrome
export CHROME_EXECUTABLE=google-chrome-stable

# Android SDK
export ANDROID_HOME=$HOME/Android/Sdk

# 10ms for key sequences
KEYTIMEOUT=1

setopt menucomplete

# History settings
# fc -RI to manually import history from other terminals
setopt histignoredups
setopt histignorespace
setopt incappendhistorytime
setopt extendedhistory
HISTFILE=~/.zshhistory
HISTSIZE=10000
SAVEHIST=10000

source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/gitfast", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
# zplug "plugins/vi-mode", from:oh-my-zsh
zplug "junegunn/fzf", use:"shell/*.zsh", defer:2
zplug "agkozak/zsh-z"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "softmoth/zsh-vim-mode"
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "b4b4r07/httpstat", \
    as:command, \
    use:'(*).sh', \
    rename-to:'$1'
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

alias gobinupdate='$HOME/go/bin/gup'

# Manage dotfiles with git bare repository
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Generate password
alias newpass="head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-' | fold -w 32 | head -n 1"

# K8s alias
alias k='kubectl'

# Prompt
# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
# # RPROMPT=\$vcs_info_msg_0_
# PROMPT=\$vcs_info_msg_0_'%# '
# zstyle ':vcs_info:git:*' formats '%b'

autoload -U promptinit; promptinit
## optionally define some options
# PURE_CMD_MAX_EXEC_TIME=10
## change the path color
# zstyle :prompt:pure:path color white
## change the color for both `prompt:success` and `prompt:error`
# zstyle ':prompt:pure:prompt:*' color cyan
## turn on git stash status
# zstyle :prompt:pure:git:stash show yes
# prompt pure

# LF
LFCD="$HOME/.config/lf/lfcd.sh"                                #  pre-built binary, make sure to use absolute path
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi
bindkey -s '^o' 'lfcd\n'  # zsh

# Nvim
alias n="nvim"

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


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/peter/tools/google-cloud-sdk/path.zsh.inc' ]; then . '/home/peter/tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/peter/tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/peter/tools/google-cloud-sdk/completion.zsh.inc'; fi
