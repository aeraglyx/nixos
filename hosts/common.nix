{ config, pkgs, pkgs-unstable, ... } @ inputs:

{
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
        cores = 8;
        max-jobs = 12;
    };

    nix.gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
    };

    time.timeZone = "Europe/Prague";
    i18n.defaultLocale = "en_US.UTF-8";

    users.users.aeraglyx = {
        isNormalUser = true;
        description = "aeraglyx";
        extraGroups = [ "networkmanager" "wheel" ];  # storage
    };

    programs.yazi.enable = true;

    environment.systemPackages = with pkgs-unstable; [
        git
        stow
        wget
        unzip
        fzf
        ripgrep
        zoxide
        python313
        killall

        alacritty
        ghostty
        neovim
        tmux
        lazygit
        starship
        fastfetch

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
