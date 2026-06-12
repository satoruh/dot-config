autoload -Uz is-at-least
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
autoload -Uz edit-command-line

unsetopt automenu
unsetopt autoremoveslash
setopt incappendhistory
setopt ignoreeof
setopt clobber
setopt equals
unsetopt flowcontrol
setopt magicequalsubst
setopt nomatch
setopt notify
setopt printeightbit
setopt printexitvalue
setopt shortloops

autoload -Uz compinit; compinit
compinit -d "${XDG_CACHE_HOME}/zcompdump-${ZSH_VERSION}"
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"

setopt extendedglob
setopt listtypes
setopt listpacked
setopt autolist
setopt markdirs

HISTFILE="${XDG_STATE_HOME}/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt append_history
setopt histexpiredupsfirst
setopt histfindnodups
setopt histignorealldups
setopt histignoredups
setopt histignorespace
setopt histnostore
setopt histreduceblanks
setopt histsavenodups
setopt histverify
setopt sharehistory
setopt extendedhistory

setopt autopushd
setopt pushdignoredups

bindkey -e

if command -v kubectl >/dev/null; then
  source <(kubectl completion zsh)
  alias k=kubectl
fi

autoload -Uz colors; colors
autoload -Uz promptinit; promptinit

unsetopt promptcr
setopt promptsubst

export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

if command -v asdf >/dev/null; then
  eval "$(asdf exec direnv hook zsh)"
fi

if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi

if [[ "$INSIDE_EMACS" = 'vterm' ]] \
    && [[ -n ${EMACS_VTERM_PATH} ]] \
    && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh ]]; then
    source ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh
fi
