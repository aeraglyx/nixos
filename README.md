# Aeraglyx's dotfiles

My personal dotfiles repository. NixOS, Hyprland, ghostty, neovim etc.


## Installation

Requires NixOS.

```bash
nix-shell -p git
git clone https://github.com/aeraglyx/nixos.git
cd ~/nixos
sudo nixos-rebuild switch --flake .#host
sh scripts/symlink.sh
```


## Theme

Uses a custom theme called Onyx. I made these stand-alone ports, the rest is currently in this repo.

- [Blender](https://github.com/aeraglyx/onyx)
- [Neovim](https://github.com/aeraglyx/onyx.nvim)
