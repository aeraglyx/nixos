{ config, pkgs, pkgs-unstable, ... } @ inputs:

{
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
        download-buffer-size = 524288000;
    };

    # nix.gc = {
    #     automatic = true;
    #     dates = "weekly";
    #     options = "--delete-older-than 7d";
    # };

    time.timeZone = "Europe/Prague";
    i18n.defaultLocale = "en_US.UTF-8";

    users.users.aeraglyx = {
        isNormalUser = true;
        description = "aeraglyx";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    documentation = {
        doc.enable = false;
        info.enable = false;
    };

    programs.zsh.enable = true;

    # environment.defaultPackages = [ ];

    environment.systemPackages = with pkgs-unstable; [
        git
        stow
        wget
        unzip
        fzf
        ripgrep
        zoxide
        killall
        bat

        alacritty
        ghostty
        neovim
        yazi
        tmux
        lazygit
        starship
        fastfetch
        cmatrix
        qrencode
        tree
        nix-tree
        translate-shell
        libqalculate
        dos2unix
        tealdeer
        # pandoc

        # languages
        gcc13
        python313

        # language servers
        nixd
        lua-language-server
        basedpyright
        bash-language-server
        rust-analyzer
    ];

    environment.variables = {
        SUDO_EDITOR = "nvim";
        EDITOR = "nvim";
        VISUAL = "nvim";
        MANPAGER = "nvim +Man!";

        XDG_CACHE_HOME  = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME   = "$HOME/.local/share";
        XDG_STATE_HOME  = "$HOME/.local/state";

        ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
        _Z_DATA = "$XDG_CONFIG_HOME/z";
        HISTFILE = "$XDG_STATE_HOME/bash_history";
        PYTHON_HISTORY = "$XDG_STATE_HOME/python_history";
    };
}
