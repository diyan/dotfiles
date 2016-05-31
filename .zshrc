# 1. Install zgen:
# $ git clone https://github.com/tarjoilija/zgen.git .zgen
# 2. Save this file into ~/.zshrc

# Run `zgen update` to apply changes made in this file

# load zgen
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
    echo "zgen init script not found. save all scripts into init script"

    zgen oh-my-zsh

    # Oh My ZSH Plugins
    zgen oh-my-zsh plugins/virtualenv
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/colored-man-pages
    # TODO evaluate oh-my-zsh plugins: sudo, fasd, taskwarrior, tmux,
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

    # Set 256 color terminal mode if available
    zgen load chrissicool/zsh-256color
    # More consistent Git aliases than Oh My ZSH provides
    zgen load sorin-ionescu/prezto modules/git/alias.zsh
    # Colorful directory listing with git features
    zgen load supercrabtree/k
    # FIXME do not show notifications for active terminals
    # zgen load marzocchi/zsh-notify
    # Preview completion for words and list-choices as you type
##    zgen load hchbaw/auto-fu.zsh
    # Show tip if command has alias
    zgen load djui/alias-tips
    # Additional completions that are not yet in Zsh
    # TODO double check that plugin works
    zgen load zsh-users/zsh-completions
    # Fish-like syntax highlighting
    zgen load zsh-users/zsh-syntax-highlighting
    # zgen load zsh-users/zsh-history-substring-search
    # Fish-like autosuggestions, check caveats below:
    # - works only if `zgen oh-my-zsh` is defined
    # - load only after zsh-syntax-highlighting, zsh-history-substring-search
    zgen load zsh-users/zsh-autosuggestions
    # Disable auto update for oh-my-zsh, let zgen to update everything
    zgen load unixorn/autoupdate-zgen
    DISABLE_AUTO_UPDATE=true
    # Use Sorin theme from oh-my-zsh
    zgen oh-my-zsh themes/sorin

    # save all to init script
    zgen save
fi

# Custom prompt for Sorin theme
function prompt_compact_pwd {
    # http://unix.stackexchange.com/a/26885
    sed "s:\([^/]\)[^/]*/:\1/:g" <<< "${PWD/#$HOME/~}"
}

# Enable hchbaw/auto-fu completion
##zle-line-init () {auto-fu-init;}; zle -N zle-line-init

#TERM=xterm-256color # enable 256 colors for vim, zsh-autosuggestions
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}git%{$reset_color%}:%{$fg[green]%}"
ZSH_THEME_VIRTUALENV_PREFIX=" %{$fg[blue]%}pyenv%{$reset_color%}:%{$fg[green]%}"
ZSH_THEME_VIRTUALENV_SUFFIX="\0"
PROMPT='%{$fg[cyan]%}$(prompt_compact_pwd)$(git_prompt_info)$(virtualenv_prompt_info) %(!.%{$fg_bold[red]%}#.%{$fg_bold[yellow]%}$)%{$reset_color%} '
