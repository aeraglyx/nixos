{ config, pkgs, pkgs-unstable, ... } @ inputs:

{
    imports = [
        ./hardware-configuration.nix
    ];

    swapDevices = [{
        device = "/swapfile";
        size = 16 * 1024;  # MB
    }];

    boot = {
        loader = {
            systemd-boot.enable = true;
            systemd-boot.configurationLimit = 3;
            efi.canTouchEfiVariables = true;
        };
        blacklistedKernelModules = [ "nouveau" ];
    };

    security = {
        rtkit.enable = true;
        polkit.enable = true;
        pam.services.hyprlock = {};
    };

    networking.hostName = "main";
    networking.firewall.enable = true;
    # networking.wireless.enable = true;
    # networking.networkmanager.enable = true;

    # services.mullvad-vpn.enable = true;
    # services.mullvad-vpn.package = pkgs-unstable.mullvad-vpn;

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

    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    services.udev = {
        packages = [ pkgs-unstable.qmk-udev-rules ];
    };

    services.power-profiles-daemon.enable = true;
    services.printing.enable = true;

    services.pulseaudio.enable = false;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        # media-session.enable = true;  # might be needed in the future
    };

    nixpkgs.config.allowUnfree = true;

    environment.sessionVariables = {
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

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        # withUWSM = true;
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
        # dfu-util

        clang-tools
        # gcc13
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
        phinger-cursors
        # catppuccin-cursors.mochaLight

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

        # zathura
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

    system.stateVersion = "24.11";
}
