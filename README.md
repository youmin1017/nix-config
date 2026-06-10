# nix-config

My personal NixOS flake configuration.

## Structure

```
.
├── flake.nix           # Flake inputs and outputs
├── hosts/
│   └── ziling-pc/      # Host-specific configuration
├── modules/
│   ├── flake/          # Flake-level module wiring
│   ├── hardware/       # Hardware modules (AMD CPU, NVIDIA GPU)
│   ├── home/           # Home Manager modules
│   │   ├── desktop/    # Hyprland desktop environment
│   │   └── programs/   # User programs (neovim, ghostty, zsh, tmux, …)
│   ├── nixos/          # NixOS system modules
│   │   ├── desktop/    # System-level desktop setup
│   │   ├── programs/   # System programs (browsers, boot, nix settings)
│   │   └── services/   # System services (kanata, tailscale, ly, …)
│   ├── locale/         # Locale configuration (zh-TW)
│   └── users/          # User account definitions
└── secrets/            # Age-encrypted secrets (ragenix)
```

## Highlights

- **Desktop**: Hyprland (Wayland compositor) with split-monitor-workspaces plugin
- **Shell**: Noctalia + Zsh + Starship prompt
- **Editors**: Neovim, Zed
- **Boot**: Lanzaboote (Secure Boot via systemd-boot)
- **Secrets**: [ragenix](https://github.com/yaxitech/ragenix) (age-encrypted secrets)
- **Overlays**: rust-overlay for Rust toolchain management

## Install

```bash
git clone --recursive https://github.com/youmin1017/nix-config ~/.config/nix
```

Then apply the configuration:

```bash
cd ~/.config/nix
just nixos
```

> Requires [just](https://github.com/casey/just). The `nixos` recipe runs `git add .` then `nixos-rebuild switch --flake .#<hostname> --impure`.
