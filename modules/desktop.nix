{ config, pkgs, pkgs-unstable, ... } @ inputs:

{
    boot.loader = {
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 3;
        efi.canTouchEfiVariables = true;
    };

    security = {
        rtkit.enable = true;
        polkit.enable = true;
        pam.services.hyprlock = {};
    };

    nixpkgs.config.allowUnfree = true;

    networking.firewall.enable = true;

    # services.mullvad-vpn.enable = true;
    # services.mullvad-vpn.package = pkgs-unstable.mullvad-vpn;

    services.clamav = {
        daemon.enable = true;
        updater.enable = true;
    };

    systemd.coredump.enable = false;

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

    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    services.udev = {
        packages = [ pkgs-unstable.qmk-udev-rules ];
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

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        package = pkgs-unstable.hyprland;
        portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
        # withUWSM = true;
    };

    programs.firefox = {
        enable = true;
        package = pkgs-unstable.firefox;
    };

    environment.systemPackages = with pkgs-unstable; [
        usbutils
        udiskie
        udisks2
        # dfu-util

        clang-tools
        gcc-arm-embedded-13
        gnumake
        pyright
        basedpyright

        hyprpaper
        hyprlock
        hypridle
        hyprsunset
        hyprpicker
        hyprcursor

        waybar
        rofi-wayland

        bibata-cursors
        # phinger-cursors

        libnotify
        dunst
        # mako
        # swaynotificationcenter

        wl-clipboard
        # cliphist
        # ydotool
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
        nerd-fonts.caskaydia-cove  # -cove or -mono
        nerd-fonts.recursive-mono
        # nerd-fonts._0xproto
        # nerd-fonts.fira-code
        # nerd-fonts.noto
        # nerd-fonts.iosevka
        font-awesome
    ];
}

