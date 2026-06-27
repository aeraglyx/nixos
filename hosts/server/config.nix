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

    zramSwap = {
        enable = true;
        algorithm = "lz4";
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 4;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.timeout = 0;

    networking.hostName = "server";
    networking.networkmanager.enable = true;
    networking.wireless.enable = true;

    services.resolved.enable = true;
    services.openssh.enable = true;

    environment.systemPackages = with pkgs; [
        brightnessctl
    ];

    system.stateVersion = "26.05";
}
