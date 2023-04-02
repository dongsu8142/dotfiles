# remove welcome message
set -g fish_greeting

# exa
if type -q exa
  alias ls "exa --icons"
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

# volta
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# nvim
command -qv nvim && alias vim nvim

# rust
set -gx PATH "$HOME/.cargo/bin" $PATH

# starship
starship init fish | source
