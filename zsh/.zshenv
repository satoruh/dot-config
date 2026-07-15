if [[ -f "${ZDOTDIR}/.zshenv.local" ]]; then
    source "${ZDOTDIR}/.zshenv.local"
fi

unsetopt global_rcs

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"

typeset -gU path

path=(
    ~/bin(N-/)
    ~/.local/bin(N-/)
    /opt/homebrew/sbin(N-/)
    /opt/homebrew/bin(N-/)
    /snap/bin(N-/)
    /usr/local/sbin(N-/)
    /usr/local/bin(N-/)
    /usr/sbin(N-/)
    /usr/bin(N-/)
    /sbin(N-/)
    /bin(N-/)
    $path
)

path=(
    ${XDG_DATA_HOME}/mise/shims(N-/)
    $path
)

if command -v brew >/dev/null; then
  path=(
      $(brew --prefix)/opt/grep/libexec/gnubin(N-/)
      $(brew --prefix)/opt/gnu-sed/libexec/gnubin(N-/)
      $path
  )
fi

if command -v go >/dev/null; then
  path=(
    $(go env GOBIN)(N-/)
    $(go env GOPATH)/bin(N-/)
    $path
  )
fi

if command -v ghcup >/dev/null; then
  path=(
    $(ghcup whereis bindir)(N-/)
    $path
  )
fi

path=(
    /usr/share/doc/git/contrib/diff-highlight(N-/)
    $path
)

if command -v brew >/dev/null; then
  path=(
      $(brew --prefix)/share/git-core/contrib/diff-highlight(N-/)
      $path
  )
fi

path=(
    ~/Applications/Emacs.app/Contents/MacOS/bin(N-/)
    $path
)
