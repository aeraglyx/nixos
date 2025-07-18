{ config, pkgs, pkgs-unstable, ... } @ inputs:

{
    imports = [
        ./hardware-configuration.nix
    ];

    swapDevices = [{
        device = "/swapfile";
        size = 16 * 1024; # MB
    }];

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 3;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.blacklistedKernelModules = [ "nouveau" ];

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

    # users.users.aeraglyx = {
    #     isNormalUser = true;
    #     description = "aeraglyx";
    #     extraGroups = [ "networkmanager" "wheel" ];
    # };

    nixpkgs.config.allowUnfree = true;
    # nixpkgs.config.nvidia.acceptLicense = true;

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

        waybar
        rofi-wayland
        hyprpaper
        hyprlock
        hypridle
        hyprsunset
        hyprpicker
        hyprcursor
        catppuccin-cursors.mochaLight

        libnotify
        swaynotificationcenter
        dunst
        mako

        wl-clipboard
        cliphist
        playerctl
        nautilus
        vlc
        (flameshot.override { enableWlrSupport = true; })
        gpu-screen-recorder
        ffmpeg
        # davinci-resolve

        clang-tools
        gcc13
        gcc-arm-embedded-13
        gnumake
        pyright
        basedpyright

        # qmk
        spotify
        discord
        vesktop
        parsec-bin
        (blender.override {
            cudaSupport = true;
        })
        tor-browser-bundle-bin
        chromium

        # inputs.vesc_tool
    ];

    system.stateVersion = "24.11";
}
