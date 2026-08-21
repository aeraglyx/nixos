{ config, pkgs, pkgs-unstable }:

{
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "25.05";
    networking.hostName = "work";

    wsl = {
        enable = true;
        defaultUser = "aeraglyx";
    };
}
