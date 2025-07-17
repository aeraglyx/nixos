# { config, pkgs, pkgs-unstable, custom-pkgs, ... } @ inputs:
{ config, pkgs, pkgs-unstable, ... } @ inputs:

{
    imports = [
        ./hardware-configuration.nix
    ];

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
        cores = 6;
        max-jobs = 12;
    };

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    swapDevices = [{
        device = "/swapfile";
        size = 16 * 1024; # MB
    }];

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 3;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.blacklistedKernelModules = [ "nouveau" ];

    networking.hostName = "nixos";
    networking.firewall.enable = true;
    # networking.wireless.enable = true;
    # networking.networkmanager.enable = true;

    # services.mullvad-vpn.enable = true;
    # services.mullvad-vpn.package = pkgs-unstable.mullvad-vpn;

    time.timeZone = "Europe/Prague";

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    services.xserver.videoDrivers = ["nvidia"];

    services.greetd = {
        enable = true;
        settings = rec {
            initial_session = {
                command = "Hyprland";
                user = "aeraglyx";
            };
            default_session = initial_session;
        };
    };

    # services.udev.enable = true;
    services.gvfs.enable = true; 
    services.udisks2.enable = true;

    services.printing.enable = true;

    security = {
        rtkit.enable = true;
        polkit.enable = true;
        pam.services.hyprlock = {};
    };

    services.pulseaudio.enable = false;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        # media-session.enable = true;
    };

    services.power-profiles-daemon.enable = true;

    users.users.aeraglyx = {
        isNormalUser = true;
        description = "aeraglyx";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    nixpkgs.config.allowUnfree = true;
    # nixpkgs.config.nvidia.acceptLicense = true;

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        # withUWSM = true;
        package = pkgs-unstable.hyprland;
        portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
    };

    environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OXONE_WL = "1";
    };

    hardware = {
        graphics.enable = true;
        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = false;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    xdg.mime.defaultApplications = {
        "inode/directory" = "nautilus.desktop";
        "x-scheme-handler/discord" = "vesktop.desktop";
    };

    programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [
        git
        stow
        wget
        unzip
        fzf
        ripgrep
        python313
        # (pkgs.python311.withPackages (ps: with ps; [
        #     custom-pkgs.fake-bpy-module
        #     pip
        #     pyside6
        # ]))

        usbutils
        udiskie
        udisks2

        pkgs-unstable.waybar
        pkgs-unstable.rofi-wayland
        pkgs-unstable.hyprpaper
        pkgs-unstable.hyprlock
        pkgs-unstable.hypridle
        pkgs-unstable.hyprsunset
        pkgs-unstable.hyprpicker
        pkgs-unstable.hyprcursor
        pkgs-unstable.catppuccin-cursors.mochaLight

        libnotify
        pkgs-unstable.swaynotificationcenter
        pkgs-unstable.dunst
        pkgs-unstable.mako

        wl-clipboard
        cliphist
        playerctl
        pkgs-unstable.nautilus
        (pkgs-unstable.flameshot.override { enableWlrSupport = true; })
        pkgs-unstable.gpu-screen-recorder
        # TODO: switch to gpu-screen-recorder-ui when available?
        pkgs-unstable.vlc
        pkgs-unstable.ffmpeg
        # pkgs-unstable.davinci-resolve

        pkgs-unstable.alacritty
        pkgs-unstable.ghostty
        # pkgs-unstable.kitty
        pkgs-unstable.tmux
        pkgs-unstable.neovim
        pkgs-unstable.lazygit
        pkgs-unstable.starship
        pkgs-unstable.fastfetch

        clang-tools
        gcc13
        gcc-arm-embedded-13
        gnumake
        pkgs-unstable.pyright
        pkgs-unstable.basedpyright
        pkgs-unstable.nixd
        lua-language-server

        # pkgs-unstable.qmk
        pkgs-unstable.spotify
        pkgs-unstable.vesktop
        pkgs-unstable.parsec-bin
        # TODO: blender-bin ?
        (pkgs-unstable.blender.override {
            cudaSupport = false;
        })
        pkgs-unstable.tor-browser-bundle-bin
        pkgs-unstable.chromium

        # inputs.vesc_tool
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

    system.stateVersion = "24.11";

}
