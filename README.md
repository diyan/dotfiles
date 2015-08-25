# dotfiles

My dotfiles are managed by [Homemaker](https://github.com/FooSoft/homemaker), check [homemaker.toml](https://github.com/diyan/dotfiles/blob/master/homemaker.toml) file for all homemaker tasks.

Homemaker is inspired by [homesick](https://github.com/technicalpickles/homesick) but much simpler/cleaner and written in Go instead of Ruby.

Here you can find my usage of i3wm, zsh, vim, etc on Arch Linux and Ubuntu.


## Installation

```sh
$ curl http://dl.foosoft.net/homemaker/homemaker_linux_amd64.tar.gz > /tmp/homemaker.tar.gz
$ cd ~/.local/bin && tar -zxf /tmp/homemaker.tar.gz --wildcards '*homemaker' --strip=1
$ git clone ssh://git@github.com/diyan/dotfiles.git ~/.dotfiles
$ homemaker ~/.dotfiles/homemaker.toml ~/.dotfiles
```
