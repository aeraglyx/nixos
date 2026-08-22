{ config, pkgs, pkgs-unstable, ... }:

{
    security = {
        rtkit.enable = true;
        polkit.enable = true;
        pam.services.hyprlock = {};
    };

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

    environment.sessionVariables = {
        TERMINAL = "ghostty";
        NIXOS_OXONE_WL = "1";
        DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    xdg.mime.enable = true;
    xdg.mime.defaultApplications = {
        "inode/directory"        = "nautilus.desktop";
        "image/*"                = "qimgv.desktop";
        "x-scheme-handler/http"  = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
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

    programs.dconf.enable = true;
    programs.dconf.profiles.user.databases = [{
        settings = {
            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
                gtk-theme = "adw-gtk3-dark";
            };
        };
    }];

    environment.systemPackages = with pkgs-unstable; [

        # WM stuff
        hyprlock
        hypridle
        hyprpicker
        hyprcursor
        bibata-cursors
        adw-gtk3
        sunsetr
        waybar
        rofi
        nautilus
        dunst

        # Terminals
        xdg-terminal-exec
        ghostty

        # Utils
        libnotify
        wl-clipboard
        cliphist
        wtype
        grim
        slurp

        # Viewers & players
        playerctl
        mpv
        zathura
        feh

        # Music
        mpc
        mpd-mpris

        # Browsers
        chromium
    ];

    fonts.fontDir.enable = true;
    fonts.packages = with pkgs-unstable; [
        nerd-fonts.caskaydia-cove
        nerd-fonts.caskaydia-mono
        font-awesome
    ];
}
