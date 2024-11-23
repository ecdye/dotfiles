if [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ -d /opt/homebrew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    HOMEBREW_PREFIX="$(brew --prefix)"
    [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] && source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
fi

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[00m\]\$ '

if comand -v gpg &> /dev/null; then
    export GPG_TTY=$(tty)
fi

export PATH="$PATH:$HOME/.local/bin"

alias ls="ls -G"
alias la="ls -la"
alias l.="ls -d .*"
alias ll="ls -l"
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
