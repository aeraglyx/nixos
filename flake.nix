{
    description = "bruh";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        hyprland.url = "github:hyprwm/Hyprland";
    };

    outputs = { nixpkgs, nixpkgs-unstable, ... } @ inputs:
        let
            system = "x86_64-linux";
            lib = nixpkgs.lib;
            # pkgs = nixpkgs.legacyPackages.${system};
            # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
            pkgs-unstable = import nixpkgs-unstable {
                system = system;
                config.allowUnfree = true;
            };
            pkgs-hypr = inputs.hyprland.packages.${system};
        in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                specialArgs = {
                    inherit pkgs-unstable;
                    inherit pkgs-hypr;
                };
                modules = [ ./configuration.nix ];
            };
        };
    };
}
