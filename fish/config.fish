# volta
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# nvim
command -qv nvim && alias vim nvim

# rust
set -gx PATH "$HOME/.cargo/bin" $PATH
