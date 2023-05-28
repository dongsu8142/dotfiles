set -g fish_greeting


set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

command -qv nvim && alias vim nvim
