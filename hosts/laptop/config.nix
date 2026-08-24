{ config, lib, pkgs, ... }:

{
    imports = [
        ./hardware.nix
    ];

    swapDevices = [{
        device = "/swapfile";
        size = 4 * 1024;  # MB
        randomEncryption.enable = true;
    }];

    networking.hostName = "laptop";
    networking.networkmanager.enable = true;
    networking.wireless.enable = true;

    services.resolved.enable = true;

    environment.systemPackages = with pkgs; [
        brightnessctl
    ];

    system.stateVersion = "26.05";
}
