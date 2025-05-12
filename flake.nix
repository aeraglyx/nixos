{
    description = "bruh";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    };

    outputs = { nixpkgs, nixpkgs-unstable, ... }:
        let
            system = "x86_64-linux";
            lib = nixpkgs.lib;
            # pkgs = nixpkgs.legacyPackages.${system};
            # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
            pkgs = import nixpkgs {
                system = system;
                config.allowUnfree = true;
            };
            pkgs-unstable = import nixpkgs-unstable {
                system = system;
                config.allowUnfree = true;
            };
        in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                # inherit system;
                specialArgs = {
                    # inherit pkgs;
                    inherit pkgs-unstable;
                };
                modules = [ ./configuration.nix ];
            };
        };
    };
}
