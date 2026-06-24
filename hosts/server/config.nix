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
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "server";
    networking.networkmanager.enable = true;
    networking.wireless.enable = true;

    services.openssh.enable = true;

    system.stateVersion = "26.05";
}
