#!/usr/bin/env bash
[[ -n "$GHOSTTY_RESOURCES_DIR" ]] && . "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
[[ -f "${HOME}"/.bashrc ]] && . "${HOME}/.bashrc"

if [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -d /opt/homebrew ]] && eval "$(/opt/homebrew/bin/brew shellenv)" && export HOMEBREW_NO_ENV_HINTS=1
    HOMEBREW_PREFIX="$(brew --prefix)"
    [[ -f "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] && . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    [[ -d "${HOMEBREW_PREFIX}/opt/gawk" ]] && export PATH="${HOMEBREW_PREFIX}/opt/gawk/libexec/gnubin:$PATH"
    if [[ -d "${HOMEBREW_PREFIX}/opt/ruby" ]]; then
        export PATH="${HOMEBREW_PREFIX}/opt/ruby/bin:$PATH"
        export PATH="${HOMEBREW_PREFIX}/lib/ruby/gems/3.4.0/bin:$PATH"
    fi
    export JAVA_HOME="$(/usr/libexec/java_home -v 21)"
    alias uk="security unlock-keychain ~/Library/Keychains/login.keychain-db"
fi

if [[ "$OSTYPE" == "linux"* ]]; then
    [[ -d /home/linuxbrew/.linuxbrew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && export HOMEBREW_NO_ENV_HINTS=1
    [[ -d /usr/sbin ]] && export PATH="/usr/sbin:${PATH}"
fi

shopt -s globstar
shopt -s checkwinsize
shopt -s histappend

export PS1='\[\e[1;92m\]\u\[\e[0m\]\[\e[1;37m\]@\[\e[0m\]\[\e[1;92m\]\h\[\e[0m\]:\[\e[1;94m\]\w\[\e[0m\]\[\e[1;91m\]$(__git_ps1)\[\e[0m\] \$ '
export PAGER='less --mouse'

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

[[ -d "${HOME}/.local/bin" ]] && export PATH="${HOME}/.local/bin:$PATH"
[[ -d "${HOME}/bin" ]] && export PATH="${HOME}/bin:$PATH"
[[ -f "/etc/profile.d/bash_completion.sh" ]] && . "/etc/profile.d/bash_completion.sh"

alias ls="ls --color=always"
alias la="ls -la"
alias l.="ls -d .*"
alias ll="ls -l"
alias grep="grep --color=always"
alias cd..="cd .."
alias cs="cd"
alias dotfiles="cd ${HOME}/dotfiles"
alias src="cd ${HOME}/src"

if command -v nvim &> /dev/null; then
    export MANPAGER='nvim +Man!'
    export EDITOR='nvim'
    alias vim="nvim"
fi

if command -v gpg &> /dev/null; then
    export GPG_TTY=$(tty)
fi

# vim: ft=bash
