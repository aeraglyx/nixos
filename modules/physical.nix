{ config, pkgs, pkgs-unstable, ... }:

{
    boot.kernelParams = [ "quiet" ];
    boot.kernel.sysctl."kernel.core_pattern" = "/dev/null";
    boot.loader = {
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 3;
        efi.canTouchEfiVariables = true;
        timeout = 0;
    };

    networking.firewall.enable = true;

    systemd.coredump.enable = false;

    services.speechd.enable = false;
    services.journald.extraConfig = "SystemMaxUse=100M";

    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    services.udev = {
        packages = [ pkgs-unstable.qmk-udev-rules ];
    };

    environment.variables = {
        ERRFILE = "$XDG_CACHE_HOME/X11/xsession-errors";
        CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
    };

    environment.systemPackages = with pkgs-unstable; [
        usbutils
        udiskie
        udisks2
        smartmontools
    ];
}
