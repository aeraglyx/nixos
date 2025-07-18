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
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    time.timeZone = "Europe/Prague";
    i18n.defaultLocale = "en_US.UTF-8";
    # i18n.extraLocaleSettings = {
    #     LC_ADDRESS = "en_US.UTF-8";
    #     LC_IDENTIFICATION = "en_US.UTF-8";
    #     LC_MEASUREMENT = "en_US.UTF-8";
    #     LC_MONETARY = "en_US.UTF-8";
    #     LC_NAME = "en_US.UTF-8";
    #     LC_NUMERIC = "en_US.UTF-8";
    #     LC_PAPER = "en_US.UTF-8";
    #     LC_TELEPHONE = "en_US.UTF-8";
    #     LC_TIME = "en_US.UTF-8";
    # };

    users.users.aeraglyx = {
        isNormalUser = true;
        description = "aeraglyx";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    environment.systemPackages = with pkgs; [
        git
        stow
        wget
        unzip
        fzf
        ripgrep
        python313

        pkgs-unstable.alacritty
        pkgs-unstable.ghostty
        pkgs-unstable.tmux
        pkgs-unstable.neovim
        pkgs-unstable.lazygit
        pkgs-unstable.starship
        pkgs-unstable.fastfetch

        pkgs-unstable.nixd
        pkgs-unstable.lua-language-server
    ];

    environment.variables.SUDO_EDITOR = "nvim";
    environment.variables.EDITOR = "nvim";
    environment.variables.VISUAL = "nvim";

    fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.caskaydia-cove  # -cove or -mono
        # nerd-fonts._0xproto
        # nerd-fonts.iosevka
        font-awesome
    ];
}
