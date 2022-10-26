# Dotfiles for pengux
Use git bare repository to manage your dotfiles

## Usage

### Initialization

```
cd $HOME
git clone --bare https://github.com/pengux/dotfiles $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout
```

### Add changes

```
dotfiles add /path/to/file
dotfiles commit -m "A short message"
dotfiles push
```
### First-time setup
```
zplug install
zplug load
nvim -c ":PackerInstall"
nvim -c "set ft=go | :GoUpdateBinaries"
systemctl --user enable --now restic-backup.timer
systemctl --user enable --now mailsync.timer
```

### Setup optional tools
```
go get github.com/joho/godotenv/cmd/godotenv
```

### To update tools
```
zplug update
nvim -c ":PackerInstall"
nvim -c "set ft=go | :GoUpdateBinaries"
```
