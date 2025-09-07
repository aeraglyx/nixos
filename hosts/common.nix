{ config, pkgs, pkgs-unstable, ... } @ inputs:

{
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
    };

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    time.timeZone = "Europe/Prague";
    i18n.defaultLocale = "en_US.UTF-8";

    users.users.aeraglyx = {
        isNormalUser = true;
        description = "aeraglyx";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    programs.zsh.enable = true;
    programs.yazi.enable = true;

    environment.systemPackages = with pkgs-unstable; [
        git
        stow
        wget
        unzip
        fzf
        ripgrep
        zoxide
        bat
        python313
        killall

        alacritty
        ghostty
        neovim
        tmux
        lazygit
        starship
        fastfetch
        cmatrix
        qrencode
        tree

        nixd
        lua-language-server
        gcc13
    ];

    environment = {
        variables = {
            SUDO_EDITOR = "nvim";
            EDITOR = "nvim";
            VISUAL = "nvim";
        };
    };
}
