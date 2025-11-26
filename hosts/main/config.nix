{ config, pkgs, pkgs-unstable, ... } @ inputs:

{
    imports = [
        ./hardware.nix
    ];

    swapDevices = [{
        device = "/swapfile";
        size = 16 * 1024;  # MB
        randomEncryption.enable = true;
    }];

    boot.blacklistedKernelModules = [ "nouveau" ];

    nix.settings = {
        cores = 8;
        max-jobs = 12;
    };

    networking.hostName = "main";

    networking.useDHCP = false;
    services.resolved.enable = true;
    systemd.network = {
        enable = true;
        wait-online.anyInterface = true;
        networks."40-enp0s31f6" = {
            matchConfig = { Name = "enp0s31f6"; };
            networkConfig = { DHCP = "yes"; };
        };
    };

    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;

    services.pulseaudio.enable = false;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        # media-session.enable = true;  # might be needed in the future
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware = {
        graphics.enable = true;
        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = false;
        };
    };

    environment.systemPackages = with pkgs-unstable; [
        liquidctl
    ];

    system.stateVersion = "24.11";
}
