if [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -d /opt/homebrew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
    HOMEBREW_PREFIX="$(brew --prefix)"
    [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] && . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    [[ -d /opt/homebrew/opt/gawk ]] && export PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"
fi

shopt -s globstar
shopt -s checkwinsize
shopt -s histappend

export PS1='\[\033[01;32m\]\u\[\033[00m\]\[\033[01;90m\]@\[\033[00m\]\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[00m\] \$ '
export MANPAGER='nvim +Man!'

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi

alias ls="ls --color=auto"
alias la="ls -la"
alias l.="ls -d .*"
alias ll="ls -l"
alias grep="grep --color=auto"
alias cd..="cd .."
alias vim="nvim"

if comand -v gpg &> /dev/null; then
    export GPG_TTY=$(tty)
fi

# vim: filetype=sh
