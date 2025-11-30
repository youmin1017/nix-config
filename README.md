# NixOS & Nix Darwin Configuration

This repository contains my personal NixOS and Nix Darwin configurations.

## Project Overview

This repository is structured to manage configurations for both NixOS (Linux) and Nix Darwin (macOS) systems.

- **`flake.nix`**: The entry point for all configurations, defining inputs and outputs for the Nix flake.
- **`homes/`**: Contains user-specific configurations managed by Home Manager, including dotfiles and modules for various applications.
  - **`homes/youmin/core/`**: Core configurations like `git`, `nvim`, `shell`, `tmux`, etc.
  - **`homes/youmin/dotfiles/`**: Managed dotfiles for applications such as `ghostty`, `hypr`, `nvim`, `rofi`, `waybar`, `wlogout`, `zed`, and `zellij`.
  - **`homes/youmin/modules/`**: Modularized Home Manager configurations. This is where applications like `hyprland`, `hypridle`, `waybar`, etc., are configured.
- **`hosts/`**: Contains system-level configurations for different machines (NixOS and Nix Darwin hosts).
  - **`hosts/darwin/`**: Configurations specific to macOS systems.
  - **`hosts/nixos/`**: Configurations specific to NixOS systems.
- **`lib/`**: Contains utility functions and Nix expressions shared across the configurations.
- **`overlays/`**: Custom Nix package overlays.

### Technologies Used

This configuration leverages the following key technologies:

- **NixOS**: A Linux distribution built on Nix, providing a declarative and reproducible system configuration.
- **Nix Darwin**: A framework for managing macOS configurations declaratively using Nix.
- **Home Manager**: A tool for managing user-specific configurations declaratively with Nix.
- **Hyprland**: A dynamic tiling Wayland compositor, configured under `homes/youmin/modules/hyprland`.
- **Waybar**: A highly customizable Wayland bar for Linux, configured under `homes/youmin/dotfiles/waybar` and `homes/youmin/modules/waybar`.
- **Neovim**: A powerful and extensible text editor, with configurations under `homes/youmin/dotfiles/nvim`.
- **Tmux**: A terminal multiplexer, configured under `homes/youmin/core/tmux.nix`.
- **Starship**: A cross-shell prompt, configured under `homes/youmin/core/starship.nix`.

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
