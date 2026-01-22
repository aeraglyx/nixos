{ config, pkgs, pkgs-unstable, lib, ... }:

{
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
        download-buffer-size = 524288000;
        use-xdg-base-directories = true;
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

    system.activationScripts = {
        diffGens = ''
            PATH=$PATH:${lib.makeBinPath [ pkgs.nix ]}
            ${pkgs.nvd}/bin/nvd diff /run/current-system "$systemConfig"
        '';
    };

    programs.zsh.enable = true;

    programs.ssh = {
        startAgent = true;
        enableAskPassword = true;
    };

    # environment.defaultPackages = [ ];

    environment.systemPackages = with pkgs-unstable; [

        # CLI tools
        git
        zoxide
        ripgrep
        tree-sitter
        tree
        stow
        wget
        unzip
        killall
        nvd
        tealdeer
        translate-shell
        libqalculate
        dos2unix
        qrencode
        bat
        direnv
        nix-direnv

        # TUI apps
        neovim
        lazygit
        yazi
        tmux
        fzf
        nix-tree
        starship
        fastfetch
        btop
        cmatrix

        # Languages
        gcc13
        python313

        # LSPs
        bash-language-server
        lua-language-server
        basedpyright
        vscode-langservers-extracted
        nixd
    ];

    environment.variables = rec {
        SUDO_EDITOR = "nvim";
        EDITOR = "nvim";
        VISUAL = "nvim";
        MANPAGER = "nvim +Man!";

        XDG_CACHE_HOME  = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME   = "$HOME/.local/share";
        XDG_STATE_HOME  = "$HOME/.local/state";

        # ZDOTDIR = "${XDG_CONFIG_HOME}/zsh";
        # _Z_DATA = "${XDG_CONFIG_HOME}/z";
        HISTFILE = "${XDG_STATE_HOME}/bash/history";
        PYTHON_HISTORY = "${XDG_STATE_HOME}/python/history";
        CARGO_HOME = "${XDG_DATA_HOME}/cargo";
        JULIA_DEPOT_PATH = "${XDG_DATA_HOME}/julia";
        CUDA_CACHE_PATH = "${XDG_CACHE_HOME}/nv";
    };
}
