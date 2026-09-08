{ config, pkgs, pkgs-unstable, ... }:

{
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "26.05";
    networking.hostName = "work";

    wsl = {
        enable = true;
        defaultUser = "aeraglyx";
    };
}
