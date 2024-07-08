set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end

starship init fish | source
~/.local/bin/mise activate fish | source
source "$HOME/.cargo/env.fish"
