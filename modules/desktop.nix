{ config, pkgs, pkgs-unstable, ... }:

{
    boot.kernelParams = [ "quiet" ];
    boot.loader = {
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 3;
        efi.canTouchEfiVariables = true;
        timeout = 0;
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
                command = "start-hyprland";
                user = "aeraglyx";
            };
            default_session = initial_session;
        };
    };

    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    services.udev = {
        packages = [ pkgs-unstable.qmk-udev-rules ];
    };

    environment.variables = {
        ERRFILE = "$XDG_CACHE_HOME/X11/xsession-errors";
    };

    environment.sessionVariables = {
        TERMINAL = "ghostty";
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

    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.package = pkgs-unstable.mullvad-vpn;

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

        # WM stuff
        hyprlock
        hypridle
        hyprpicker
        hyprcursor
        bibata-cursors
        sunsetr
        waybar
        rofi
        nautilus
        dunst

        # Terminals
        xdg-terminal-exec
        alacritty
        ghostty
        kitty

        # Utils
        libnotify
        wl-clipboard
        cliphist
        wtype

        # Disc stuff
        usbutils
        udiskie
        udisks2

        # Capture
        (flameshot.override { enableWlrSupport = true; })
        gpu-screen-recorder
        # hyprshot

        # CLI tools
        playerctl
        ffmpeg
        imagemagick
        exiftool
        pass

        # Viewers & players
        mpv
        zathura
        loupe
        # vlc
        # mpd
        # rmpc
        # spotify
        # libreoffice

        # Media creation
        blender_4_5
        blender_5_0
        # (blender.override { cudaSupport = true; })
        # davinci-resolve
        # gimp3
        # djv

        # Messaging
        discord
        signal-desktop

        # Browsers
        qutebrowser
        chromium
        google-chrome
        tor-browser
        librewolf
        zen-browser

        # Miscellaneous
        # parsecgaming
        # pkgs.parsec-bin
        # vesc_tool
    ];

    fonts.packages = with pkgs-unstable; [
        nerd-fonts.caskaydia-cove
        nerd-fonts.caskaydia-mono
        font-awesome
    ];
}
