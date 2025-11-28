# My NixOS & Nix Darwin Configurations

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/9bd16a1b-c92c-437a-bb27-0d757b35cbef" />


## Download this project

```bash
$ git clone git@github.com:youmin1017/nix-config.git ~/.config/nix
```
## Install

```bash
export IMPURITY_PATH=~/.config/nix
sudo --preserve-env=IMPURITY_PATH nixos-rebuild switch --upgrade --flake .#{{ hostname }} --impure

# or
just nixos
```
