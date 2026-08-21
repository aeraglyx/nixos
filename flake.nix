{
    description = "Aeraglyx's Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        nixos-wsl = {
            url = "github:nix-community/NixOS-WSL";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };
    };

    outputs = { nixpkgs, nixpkgs-unstable, ... } @ inputs:
        let
            system = "x86_64-linux";
            lib = nixpkgs.lib;
            overlays = [
                (import ./overlays/blender.nix)
            ];
            pkgs-unstable = import nixpkgs-unstable {
                system = system;
                config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
                    "discord"
                    "discord-unwrapped"
                    "google-chrome"
                    "parsec-bin"
                ];
                overlays = overlays;
            };
            custom-pkgs = import ./modules/custom-pkgs.nix { inherit pkgs-unstable; };
        in {
        nixosConfigurations = {
            main = lib.nixosSystem {
                specialArgs = {
                    inherit pkgs-unstable;
                };
                modules = [
                    ./hosts/main/config.nix
                    ./modules/common.nix
                    ./modules/physical.nix
                    ./modules/desktop.nix
                    ./modules/extras.nix
                ];
            };
            work = lib.nixosSystem {
                specialArgs = {
                    inherit pkgs-unstable;
                };
                modules = [
                    ./hosts/work/config.nix
                    "${inputs.nixos-wsl}/modules"
                    ./modules/common.nix
                ];
            };
            laptop = lib.nixosSystem {
                specialArgs = {
                    inherit pkgs-unstable;
                };
                modules = [
                    ./hosts/laptop/config.nix
                    ./modules/common.nix
                    ./modules/physical.nix
                    ./modules/desktop.nix
                ];
            };
            server = lib.nixosSystem {
                specialArgs = {
                    inherit pkgs-unstable;
                };
                modules = [
                    ./hosts/server/config.nix
                    ./modules/common.nix
                    ./modules/physical.nix
                ];
            };
        };
        devShells.${system} = {
            blender = pkgs-unstable.mkShell {
                packages = [
                    (pkgs-unstable.python314.withPackages (ps: [
                        custom-pkgs.fake-bpy-module
                    ]))
                ];
            };
        };
    };
}
