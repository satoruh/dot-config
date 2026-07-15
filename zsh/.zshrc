unsetopt automenu
unsetopt autoremoveslash
setopt ignoreeof
unsetopt flowcontrol
setopt magicequalsubst
setopt printeightbit
setopt printexitvalue

autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}/zcompdump-${ZSH_VERSION}"
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"

setopt extendedglob
setopt listpacked
setopt markdirs

HISTFILE="${XDG_STATE_HOME}/zsh/history"
HISTSIZE=100000
SAVEHIST=100000
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"

setopt histexpiredupsfirst
setopt histfindnodups
setopt histignorealldups
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

if command -v gpgconf >/dev/null; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

if command -v mise >/dev/null; then
  eval "$(mise activate zsh)"
fi

if command -v direnv >/dev/null; then
  eval "$(direnv hook zsh)"
fi

if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi

if [[ "$INSIDE_EMACS" = 'vterm' ]] \
    && [[ -n ${EMACS_VTERM_PATH} ]] \
    && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh ]]; then
    source ${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh
fi
