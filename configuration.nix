{ config, pkgs, pkgs-unstable, ... } @ inputs:

{
    imports =
        [
            ./hardware-configuration.nix
        ];

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 8;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.blacklistedKernelModules = [ "nouveau" ];

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Prague";

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # Enable the X11 windowing system.
    # services.xserver.enable = true;

    services.xserver.videoDrivers = ["nvidia"];

    # # Enable the GNOME Desktop Environment.
    # services.xserver.displayManager.gdm.enable = true;
    # services.xserver.desktopManager.gnome.enable = true;
    #
    # # Configure keymap in X11
    # services.xserver.xkb = {
    #     layout = "us";
    #     variant = "";
    # };

    services.greetd = {
        enable = true;
        settings = rec {
            initial_session = {
                command = "Hyprland";
                user = "aeraglyx";
            };
            default_session = initial_session;
        };
    };

    services.udev.enable = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    security = {
        rtkit.enable = true;
        polkit.enable = true;
        # pam.services.hyprlock = {};
    };

    # Enable sound with pipewire.
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        jack.enable = true;
        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        # media-session.enable = true;
    };

    users.users.aeraglyx = {
        isNormalUser = true;
        description = "aeraglyx";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    nixpkgs.config.allowUnfree = true;

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        # withUWSM = true;
        package = inputs.pkgs-hypr.hyprland;
        portalPackage = inputs.pkgs-hypr.xdg-desktop-portal-hyprland;
    };

    environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OXONE_WL = "1";
    };

    hardware = {
        pulseaudio.enable = false;
        graphics.enable = true;
        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = false;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [
        git
        stow
        wget
        unzip
        fzf
        lazygit
        ripgrep
        python313

        waybar
        rofi-wayland
        hyprpaper
        hyprlock
        hypridle
        hyprsunset
        hyprpicker
        hyprcursor
        swaynotificationcenter
        wl-clipboard
        cliphist
        playerctl
        catppuccin-cursors.mochaLight

        tmux
        kitty
        neovim
        # helix
        starship

        clang-tools
        pyright
        gcc13
        gnumake
        nil
        lua-language-server

        qmk
        spotify
        vesktop
        # parsec-bin
        pkgs-unstable.parsec-bin
        # blender
        # cudatoolkit
    ];

    environment.variables.SUDO_EDITOR = "nvim";
    environment.variables.EDITOR = "nvim";
    environment.variables.VISUAL = "nvim";

    fonts.packages = with pkgs; [
        # TODO refactor after 25.05
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
        fira-code
        font-awesome
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    #
    # List services that you want to enable:
    #
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
    #
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    system.stateVersion = "24.11";

}
