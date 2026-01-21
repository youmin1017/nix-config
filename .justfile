# List all recipes
_default:
    @printf '\033[1;36mnixcfg recipes\033[0m\n\n'
    @printf '\033[1;33mUsage:\033[0m just <recipe> [args...]\n\n'
    @just --list --list-heading $'Available recipes:\n\n'

export IMPURITY_PATH := source_dir()
hostname := `if [ "$(uname)" = "Darwin" ]; then scutil --get LocalHostName; else hostname -s; fi`

[group('darwin')]
darwin:
    sudo --preserve-env darwin-rebuild switch --flake .#{{ hostname }} --impure

[group('darwin')]
darwin-init:
    nix build .#darwinConfigurations.{{ hostname }}.system \
      --impure --extra-experimental-features 'nix-command flakes'
    sudo --preserve-env ./result/sw/bin/darwin-rebuild switch --flake .#{{ hostname }} --impure

[group('nixos')]
nixos:
    sudo --preserve-env=IMPURITY_PATH nixos-rebuild switch --upgrade --flake .#{{ hostname }} --impure
