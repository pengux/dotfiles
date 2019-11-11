# Dotfiles for pengux
Use git bare repository to manage your dotfiles

## Usage

### Initialization

```
mkdir $HOME/dotfiles
git init --bare $HOME/dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
dotfiles remote add origin https://github.com/pengux/dotfiles
dotfiles branch --set-upstream-to=origin/master master
dotfiles config --local status.showUntrackedFiles no
dotfiles pull --rebase
```

### Add changes

```
dotfiles add /path/to/file
dotfiles commit -m "A short message"
dotfiles push
```
