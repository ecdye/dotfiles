#!/usr/bin/env bash
[[ -f "${HOME}/.bashrc" ]] && . "${HOME}/.bashrc"
[[ -f "${HOME}/.env" ]] && . "${HOME}/.env"

if [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -d /opt/homebrew ]] && eval "$(/opt/homebrew/bin/brew shellenv)" && export HOMEBREW_NO_ENV_HINTS=1
    [[ -f "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] && . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    JAVA_HOME="$(/usr/libexec/java_home -v 21 2>/dev/null || /usr/libexec/java_home 2>/dev/null)" && export JAVA_HOME
    alias uk="security unlock-keychain ~/Library/Keychains/login.keychain-db"
    alias cdx='codex "Read ./AGENTS.md and say '\''Ready'\''"'
fi

if [[ "$OSTYPE" == "linux"* ]]; then
    [[ -d /home/linuxbrew/.linuxbrew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && export HOMEBREW_NO_ENV_HINTS=1
    [[ -d /usr/sbin ]] && export PATH="/usr/sbin:${PATH}"
    [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]] && . /usr/share/git-core/contrib/completion/git-prompt.sh
fi
[[ -d "${HOME}/conda" ]] && . "${HOME}/conda/bin/activate"

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
PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

[[ -d "${HOME}/.local/bin" ]] && export PATH="${HOME}/.local/bin:$PATH"
[[ -d "${HOME}/bin" ]] && export PATH="${HOME}/bin:$PATH"
[[ -f "/etc/profile.d/bash_completion.sh" ]] && . "/etc/profile.d/bash_completion.sh"

export NVM_DIR="${HOME}/.nvm"
if [[ -s "${NVM_DIR}/nvm.sh" ]]; then
    # Sourcing nvm.sh adds ~0.3s to every shell, so put the default Node on PATH now and load nvm on first use.
    __nvm_default="$(cat "${NVM_DIR}/alias/default" 2>/dev/null)"
    __nvm_bin="$(ls -d "${NVM_DIR}/versions/node/v${__nvm_default#v}"*/bin 2>/dev/null | sort -V | tail -1)"
    [[ -n "$__nvm_bin" ]] || __nvm_bin="$(ls -d "${NVM_DIR}/versions/node/v"*/bin 2>/dev/null | sort -V | tail -1)"
    [[ -n "$__nvm_bin" ]] && export PATH="${__nvm_bin}:$PATH"
    unset __nvm_default __nvm_bin
    # --no-use keeps nvm.sh from switching to the default and clobbering a version direnv picked.
    nvm() {
        unset -f nvm
        . "${NVM_DIR}/nvm.sh" --no-use
        [[ -s "${NVM_DIR}/bash_completion" ]] && . "${NVM_DIR}/bash_completion"
        nvm "$@"
    }
    export -f nvm
fi

alias ls="ls --color=auto"
alias la="ls -la"
alias l.="ls -d .*"
alias ll="ls -l"
alias grep="grep --color=auto"
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

if command -v direnv &> /dev/null; then
    eval "$(direnv hook bash)"
fi

# vim: ft=bash
