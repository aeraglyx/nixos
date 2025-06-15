{ config, pkgs, pkgs-unstable, ... } @ inputs:

{
    imports = [
        ./hardware-configuration.nix
    ];

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
    };

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 3;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.blacklistedKernelModules = [ "nouveau" ];

    networking.hostName = "nixos";
    # networking.wireless.enable = true;
    # networking.networkmanager.enable = true;

    networking.firewall.enable = true;
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];

    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.package = pkgs-unstable.mullvad-vpn;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

    # Enable the X11 windowing system.
    # services.xserver.enable = true;

    services.xserver.videoDrivers = ["nvidia"];
    # services.xserver.updateDbusEnvironment = true;

    # # Enable the GNOME Desktop Environment.
    # services.xserver.displayManager.gdm.enable = true;
    # services.xserver.desktopManager.gnome.enable = true;

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

    services.udev.enable = true;

    # services.devmon.enable = true;
    services.gvfs.enable = true; 
    services.udisks2.enable = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    security = {
        rtkit.enable = true;
        polkit.enable = true;
        pam.services.hyprlock = {};
    };

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

    users.users.aeraglyx = {
        isNormalUser = true;
        description = "aeraglyx";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    nixpkgs.config.allowUnfree = true;

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        # withUWSM = true;
        package = inputs.pkgs-unstable.hyprland;
        portalPackage = inputs.pkgs-unstable.xdg-desktop-portal-hyprland;
    };

    environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OXONE_WL = "1";
    };

    hardware = {
        pulseaudio.enable = false;
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
        lazygit
        ripgrep
        # python314
        (pkgs.python314.withPackages (ps: [
            (ps.buildPythonPackage {
                pname = "fake-bpy-module";
                version = "20250613";
                # src = ps.fetchPypi {
                src = pkgs.fetchurl {
                    url = "https://files.pythonhosted.org/packages/source/f/fake-bpy-module/fake_bpy_module-20250613.tar.gz";
                    # inherit pname version;
                    sha256 = "sha256-/ZMG3ixkhmZZstfOD/1aUeU1zq9Zc/hRCpVmTJVryTw=";
                };
                doCheck = false;
                pythonImportsCheck = [ "bpy" ];
            })
        ]))

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
        (flameshot.override { enableWlrSupport = true; })

        pkgs-unstable.tmux
        pkgs-unstable.kitty
        pkgs-unstable.alacritty
        pkgs-unstable.neovim
        pkgs-unstable.starship

        clang-tools
        gcc13
        gnumake
        pkgs-unstable.pyright
        pkgs-unstable.basedpyright
        # nil
        pkgs-unstable.nixd
        lua-language-server

        pkgs-unstable.qmk
        pkgs-unstable.spotify
        pkgs-unstable.vesktop
        pkgs-unstable.parsec-bin
        pkgs-unstable.blender
        pkgs-unstable.tor-browser-bundle-bin
        pkgs-unstable.chromium
        # cudatoolkit

        pkgs-unstable.fastfetch
    ];

    environment.variables.SUDO_EDITOR = "nvim";
    environment.variables.EDITOR = "nvim";
    environment.variables.VISUAL = "nvim";

    fonts.packages = with pkgs; [
        # TODO refactor after 25.05
        # nerd-fonts.caskaydia-cove  # or mono for no ligatures
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
        fira-code
        font-awesome
        maple-mono
        cascadia-code
        iosevka
        _0xproto
    ];

    system.stateVersion = "24.11";

}
