# just is a command runner, Justfile is very similar to Makefile, but simpler.

# TODO update hostname here!
hostname := `if [ "$(uname)" = "Darwin" ]; then scutil --get LocalHostName; else hostname -s; fi`

############################################################################
#
#  Darwin related commands
#
############################################################################
export IMPURITY_PATH := source_dir()
[group('darwin')]
darwin:
  sudo --preserve-env darwin-rebuild switch --flake .?submodules=1#{{hostname}} --impure
  
[group('darwin')]
install-nix-darwin:
  nix build .?submodules=1#darwinConfigurations.{{hostname}}.system \
    --impure --extra-experimental-features 'nix-command flakes'
  
  sudo --preserve-env ./result/sw/bin/darwin-rebuild switch --flake .?submodules=1#{{hostname}} --impure

#
############################################################################
#  NixOS related commands
#
############################################################################
[group('nixos')]
nixos:
  sudo --preserve-env=IMPURITY_PATH nixos-rebuild switch --upgrade --flake .?submodules=1#{{hostname}} --impure

# List all the just commands
default:
    @just --list

# Update all the flake inputs
[group('nix')]
up:
  nix flake update

# Update specific input
# Usage: just upp nixpkgs
[group('nix')]
upp input:
  nix flake update {{input}}

# List all generations of the system profile
[group('nix')]
history:
  nix profile history --profile /nix/var/nix/profiles/system

# Open a nix shell with the flake
[group('nix')]
repl:
  nix repl -f flake:nixpkgs

# remove all generations older than 7 days
# on darwin, you may need to switch to root user to run this command
[group('nix')]
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

# Garbage collect all unused nix store entries
[group('nix')]
gc:
  # garbage collect all unused nix store entries(system-wide)
  sudo nix-collect-garbage --delete-older-than 7d
  # garbage collect all unused nix store entries(for the user - home-manager)
  # https://github.com/NixOS/nix/issues/8508
  nix-collect-garbage --delete-older-than 7d

[group('nix')]
fmt:
  # format the nix files in this repo
  nix fmt

# Show all the auto gc roots in the nix store
[group('nix')]
gcroot:
  ls -al /nix/var/nix/gcroots/auto/

[group('git')]
update-homes:
  git add homes
  git commit -m "Update homes" || echo "No changes to commit"
