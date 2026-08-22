{ config, pkgs, pkgs-unstable, ... }:

{
    services.tailscale.enable = true;
    services.tailscale.package = pkgs-unstable.tailscale;

    services.mpd = {
        enable = true;
        user = "aeraglyx";
        settings = {
            music_directory = "/home/aeraglyx/moosic";
            audio_output = [{
                type = "pipewire";
                name = "pipewire output";
            }];
        };
    };

    systemd.services.mpd.environment = {
        XDG_RUNTIME_DIR = "/run/user/1000";
    };

    environment.systemPackages = with pkgs-unstable; [

        # Terminals
        alacritty

        # Utils
        showmethekey
        tesseract

        # Capture
        flameshot
        gpu-screen-recorder
        # hyprshot

        # CLI tools
        ffmpeg
        imagemagick
        exiftool
        pass

        # Viewers & players
        # loupe
        # nsxiv
        # qimgv
        # nomacs
        # vlc
        # libreoffice

        # Music
        rmpc
        puddletag

        # Media creation
        blender_5_2
        # gimp3
        # djv

        # Messaging
        discord
        signal-desktop

        # Browsers
        qutebrowser
        google-chrome
        tor-browser

        # Remote Desktop
        moonlight-qt
        parsec-bin
    ];
}
