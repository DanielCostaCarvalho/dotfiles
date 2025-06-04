set fish_greeting
set -gx EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end

starship init fish | source
mise activate fish | source
# source "$HOME/.cargo/env.fish"
