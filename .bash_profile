#!/usr/bin/env bash
[[ -n "$GHOSTTY_RESOURCES_DIR" ]] && . "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
[[ -f "${HOME}"/.bashrc ]] && . "${HOME}/.bashrc"

if [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -d /opt/homebrew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
    HOMEBREW_PREFIX="$(brew --prefix)"
    [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] && . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    [[ -d "${HOMEBREW_PREFIX}/opt/gawk" ]] && export PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"
    export JAVA_HOME="$(/usr/libexec/java_home -v 21)"
    alias unlock-keychain="security unlock-keychain ~/Library/Keychains/login.keychain-db"
fi

shopt -s globstar
shopt -s checkwinsize
shopt -s histappend

export PS1='\[\e[1;92m\]\u\[\e[0m\]\[\e[1;37m\]@\[\e[0m\]\[\e[1;92m\]\h\[\e[0m\]:\[\e[1;94m\]\w\[\e[0m\]\[\e[1;91m\]$(__git_ps1)\[\e[0m\] \$ '
export PAGER='less --mouse'

[[ -d "${HOME}/.local/bin" ]] && export PATH="${HOME}/.local/bin:$PATH"
[[ -d "${HOME}/bin" ]] && export PATH="${HOME}/bin:$PATH"
[[ -r "/etc/profile.d/bash_completion.sh" ]] && . "/etc/profile.d/bash_completion.sh"

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

# vim: filetype=bash
