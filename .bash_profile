if [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -d /opt/homebrew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
    HOMEBREW_PREFIX="$(brew --prefix)"
    [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] && source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
fi

shopt -s globstar
shopt -s checkwinsize
shopt -s histappend

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[00m\] \$ '
export PATH="$PATH:$HOME/.local/bin"
export TERM=xterm-256color

alias ls="ls -G"
alias la="ls -la"
alias l.="ls -d .*"
alias ll="ls -l"
alias grep="grep --color=auto"
alias cd..="cd .."

if command -v nvim &> /dev/null; then
    vim () {
	if [[ -z "$@" ]]; then
	    if [[ -f "./Session.vim" ]]; then
		nvim -S Session.vim -c 'lua vim.g.savesession = true'
	    else
		nvim -c 'lua vim.g.savesession = true'
	    fi
	else
	    nvim "$@"
	fi
    }
fi

if comand -v gpg &> /dev/null; then
    export GPG_TTY=$(tty)
fi

