{ config, pkgs, pkgs-unstable, ... } @ inputs:

{
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "25.05";
    networking.hostName = "work";

    wsl = {
        enable = true;
        defaultUser = "aeraglyx";
    };

    # environment.systemPackages = with pkgs-unstable; [
    #     blender_4_5
    #     qmk
    # ];
}

