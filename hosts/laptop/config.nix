{ pkgs, lib, ... }:

{
    imports = [
        ./hardware.nix
    ];

    swapDevices = [{
        device = "/swapfile";
        size = 4 * 1024;  # MB
        randomEncryption.enable = true;
    }];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "nvidia-x11"
        "nvidia-kernel-modules"
    ];

    networking.hostName = "laptop";
    networking.networkmanager.enable = true;
    networking.wireless.enable = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware = {
        graphics.enable = true;
        nvidia = {
            modesetting.enable = true;
            open = false;
            nvidiaSettings = false;
            prime = {
                sync.enable = true;
                intelBusId = "PCI:0@0:2:0";
                nvidiaBusId = "PCI:1@0:0:0";
            };
        };
    };

    services.resolved.enable = true;

    environment.systemPackages = with pkgs; [
        brightnessctl
    ];

    system.stateVersion = "26.05";
}
