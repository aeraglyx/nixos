{ config, lib, pkgs, ... }:

{
    imports = [
        <nixos-wsl/modules>
    ];

    wsl.enable = true;
    wsl.defaultUser = "aeraglyx";

    time.timeZone = "Europe/Prague";

    users.users.aeraglyx = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
    };

    environment.systemPackages = with pkgs; [
        git
        stow
        wget
        unzip
        fzf
        lazygit
        ripgrep

        tmux
        kitty
        neovim
        helix

        clang-tools
        pyright
        gcc13
        gnumake
        nil
        lua-language-server

        qmk
    ];

    environment.variables.EDITOR = "nvim";

    system.stateVersion = "24.11";
}
