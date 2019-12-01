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
chmod +x $HOME/.config/polybar/launch.sh
chmod +x $HOME/.config/polybar/scripts/check-all-updates.sh
zplug install
zplug load
vim +PlugInstall +qall
```

### Setup optional tools
```
go get github.com/joho/godotenv/cmd/godotenv
systemctl --user enable --now restic-backup-timer
```
