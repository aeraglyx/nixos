{ config, pkgs, pkgs-unstable, ... }:

{
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

        # Utils
        showmethekey
        tesseract
        czkawka

        # Capture
        flameshot
        pkgs.gpu-screen-recorder

        # CLI tools
        ffmpeg
        imagemagick
        exiftool
        yt-dlp

        # Viewers & players
        gthumb
        qimgv
        loupe

        # Music
        rmpc
        puddletag

        # Media creation
        blender
        blender_5_2

        # Messaging
        discord
        signal-desktop

        # Browsers
        qutebrowser
        google-chrome
        tor-browser

        # Remote Desktop
        parsec-bin
    ];
}
