# Fish Config

## Set Terminal
- download fish from pacman
sudo pacman -S fish
- change fish to default fish
chsh -s `which fish`

## To source new config of fish shell
source ~/.config/fish/config.fish 

## Plugin Manager
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

## Vim mode
https://fishshell.com/docs/current/interactive.html

nvim ~/config/fish/config.fish
```fish
function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
end

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursor to an underscore
set fish_cursor_replace_one underscore
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block
```

## EXA [exa](https://github.com/ogham/exa)

- install
sudo pacman -S exa 
- add to config.fish
```fish
alias l='exa'
alias ll='exa --header --group --created --modified -l'
alias la='exa --header --group --created --modified -l -all'
alias lt='exa --tree'
```

exa --icons
[exa-features](https://the.exa.website/features/tree-view)

## Zoxide [zoxide](https://github.com/ajeetdsouza/zoxide#installation)
cd tool
zoxide init fish | source
cargo install zoxide --locked

## Starship [starship](https://github.com/starship/starship)
```fish
https://github.com/starship/starship
```
