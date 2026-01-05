{ config, pkgs, pkgs-unstable, lib, ... } @ inputs:

{
    imports = [
        ./hardware.nix
    ];

    swapDevices = [{
        device = "/swapfile";
        size = 16 * 1024;  # MB
        randomEncryption.enable = true;
    }];

    zramSwap = {
        enable = true;
        algorithm = "lz4";
    };

    boot.blacklistedKernelModules = [ "nouveau" ];

    nix.settings = {
        cores = 8;
        max-jobs = 12;
    };

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "nvidia-x11"
    ];

    networking.hostName = "main";
    networking.useNetworkd = true;

    systemd.network.wait-online.enable = false;

    services.resolved.enable = true;
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
