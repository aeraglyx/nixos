{ config, pkgs, pkgs-unstable, ... } @ inputs:

{
    boot.kernelParams = [ "quiet" ];
    boot.loader = {
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 3;
        timeout = 1;
        efi.canTouchEfiVariables = true;
    };

    security = {
        rtkit.enable = true;
        polkit.enable = true;
        pam.services.hyprlock = {};
    };

    networking.firewall.enable = true;

    systemd.coredump.enable = false;
    services.speechd.enable = false;
    services.journald.extraConfig = "SystemMaxUse=50M";

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

    nixpkgs.config.allowUnfree = true;

    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    services.udev = {
        packages = [ pkgs-unstable.qmk-udev-rules ];
    };

    environment.variables = {
        # USERXSESSION = "$XDG_CACHE_HOME/X11/xsession";
        # USERXSESSIONRC = "$XDG_CACHE_HOME/X11/xsessionrc";
        # ALTUSERXSESSION = "$XDG_CACHE_HOME/X11/Xsession";
        ERRFILE = "$XDG_CACHE_HOME/X11/xsession-errors";
    };

    environment.sessionVariables = {
        NIXOS_OXONE_WL = "1";
        DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    xdg.mime.enable = true;
    xdg.mime.defaultApplications = {
        "inode/directory"           = [ "nautilus.desktop" ];
        "default-web-browser"       = [ "firefox.desktop" ];
        "text/html"                 = [ "firefox.desktop" ];
        "x-scheme-handler/ftp"      = [ "firefox.desktop" ];
        "x-scheme-handler/http"     = [ "firefox.desktop" ];
        "x-scheme-handler/https"    = [ "firefox.desktop" ];
        "x-scheme-handler/about"    = [ "firefox.desktop" ];
        "x-scheme-handler/unknown"  = [ "firefox.desktop" ];
        "x-scheme-handler/discord"  = [ "vesktop.desktop" ];
    };

    # services.mullvad-vpn.enable = true;
    # services.mullvad-vpn.package = pkgs-unstable.mullvad-vpn;

    services.clamav = {
        daemon.enable = true;
        updater.enable = false;
    };

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        package = pkgs-unstable.hyprland;
        portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
    };

    programs.firefox = {
        enable = true;
        package = pkgs-unstable.firefox;
    };

    environment.systemPackages = with pkgs-unstable; [
        usbutils
        udiskie
        udisks2

        clang-tools
        gcc-arm-embedded-13
        gnumake

        hyprpaper
        hyprlock
        hypridle
        hyprsunset
        hyprpicker
        hyprcursor
        sunsetr

        waybar
        rofi

        bibata-cursors

        libnotify
        dunst
        # mako
        # swaynotificationcenter

        wl-clipboard
        # cliphist
        nautilus

        hyprshot
        (flameshot.override { enableWlrSupport = true; })
        gpu-screen-recorder

        playerctl
        ffmpeg
        mpv
        vlc

        zathura
        # libreoffice

        blender_4_5
        # (blender.override { cudaSupport = true; })
        # davinci-resolve
        # gimp3
        # djv
        # exiftool

        spotify
        discord
        vesktop
        parsec-bin
        obsidian
        pass
        clamav

        qutebrowser
        tor-browser-bundle-bin
        chromium
        google-chrome

        qmk
        # inputs.vesc_tool
    ];

    fonts.packages = with pkgs-unstable; [
        nerd-fonts.caskaydia-cove
        nerd-fonts.caskaydia-mono
        # nerd-fonts.recursive-mono
        font-awesome
    ];
}
