# 1. Install zgen:
# $ git clone https://github.com/tarjoilija/zgen.git ~/.zgen/zgen
# 2. Save this file into ~/.zshrc

# load zgen
source "${HOME}/.zgen/zgen/zgen.zsh"

if ! zgen saved; then
    echo "zgen init script not found. save all scripts into init script"

    zgen oh-my-zsh

    # Oh My ZSH Plugins
    # TODO switch into prezto git plugin
    #zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/virtualenv
    zgen oh-my-zsh plugins/command-not-found
    # TODO evaluate oh-my-zsh plugins: git, sudo, fasd, taskwarrior, tmux,
    #   rsync, archlinux, mosh, history, pip, python, systemd, brew,
    #   docker,
    # TODO evaluate Tarrasch/zsh-bd, Tarrasch/zsh-colors, tarruda/zsh-autosuggestions
    # TODO Consider call "unsetopt share_history"
    # https://github.com/faceleg/dotfiles/blob/master/configuration/zshrc
    # https://github.com/faceleg/dotfiles/blob/master/configuration/zshrc
    # https://github.com/desyncr/zshrc/blob/master/.antigenrc
    # https://raw.githubusercontent.com/MaxUlysse/myzsh/master/.zshrc
    # https://github.com/MaxUlysse/myzsh/blob/master/.zshrc
    # https://github.com/rummik/dotfiles/blob/master/.zshrc
    # https://github.com/sharat87/lawn/blob/master/shell/zsh

    # Prezto has more consistent Git aliases than Oh My ZSH
    zgen load sorin-ionescu/prezto modules/git/alias.zsh
    zgen load walesmd/caniuse.plugin.zsh
    zgen load supercrabtree/k

    # FIXME do not show notifications for active terminals
    # zgen load marzocchi/zsh-notify

    # ERROR Cannot rebind self-insert: user:url-quote-magic
    #zgen load hchbaw/auto-fu.zsh

    zgen load zsh-users/zsh-completions src

    # Note zsh-syntax-highlighting and only then zsh-history-substring-search
    #zgen load zsh-users/zsh-syntax-highlighting
    #zgen load zsh-users/zsh-history-substring-search
    # TODO double check order: zsh-syntax-highlighting then zsh-autosuggestions
    # FIXME zsh-autosuggestions breaks zsh-syntax-highlighting a bit
    zgen load tarruda/zsh-autosuggestions

    # Enable autosuggestions automatically
    zle-line-init() {
        zle autosuggest-start
    }
    zle -N zle-line-init

    # use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
    # zsh-autosuggestions is designed to be unobtrusive)
    bindkey '^T' autosuggest-toggle

    # Sorin theme
    zgen oh-my-zsh themes/sorin

    # save all to init script
    zgen save
fi

# Customize Sorin theme
function prompt_compact_pwd {
    # http://unix.stackexchange.com/a/26885
    sed "s:\([^/]\)[^/]*/:\1/:g" <<< "${PWD/#$HOME/~}"
}

TERM=xterm-256color # enable 256 colors for vim, zsh-autosuggestions
# I'm using underscore cursor, so highlight word after cursor
AUTOSUGGESTION_HIGHLIGHT_CURSOR=0
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}git%{$reset_color%}:%{$fg[green]%}"
ZSH_THEME_VIRTUALENV_PREFIX=" %{$fg[blue]%}pyenv%{$reset_color%}:%{$fg[green]%}"
ZSH_THEME_VIRTUALENV_SUFFIX="\0"
PROMPT='%{$fg[cyan]%}$(prompt_compact_pwd)$(git_prompt_info)$(virtualenv_prompt_info) %(!.%{$fg_bold[red]%}#.%{$fg_bold[yellow]%}$)%{$reset_color%} '

# Qt-based apps must use GTK theme
export QT_STYLE_OVERRIDE=gtk
