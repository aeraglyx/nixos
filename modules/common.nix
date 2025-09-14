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
        python313
        killall
        bat
        yazi

        alacritty
        ghostty
        neovim
        # tmux
        lazygit
        starship
        fastfetch
        cmatrix
        qrencode
        tree
        nix-tree

        nixd
        lua-language-server
        gcc13
    ];

    environment.variables = {
        SUDO_EDITOR = "nvim";
        EDITOR = "nvim";
        VISUAL = "nvim";

        XDG_CACHE_HOME  = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME   = "$HOME/.local/share";
        XDG_STATE_HOME  = "$HOME/.local/state";

        ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
        _Z_DATA = "$XDG_CONFIG_HOME/z";
        PYTHON_HISTORY = "$XDG_STATE_HOME/python_history";
    };
}
