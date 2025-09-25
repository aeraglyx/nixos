{
    description = "Aeraglyx's Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        nixos-wsl = {
            url = "github:nix-community/NixOS-WSL";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };
        blender-bin = {
            url = "github:edolstra/nix-warez?dir=blender";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };
        vesc_tool-flake = {
            url = "github:lukash/vesc_tool-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, nixpkgs-unstable, ... } @ inputs:
        let
            system = "x86_64-linux";
            lib = nixpkgs.lib;
            pkgs = import nixpkgs {
                system = system;
                config.allowUnfree = true;
            };
            pkgs-unstable = import nixpkgs-unstable {
                system = system;
                config.allowUnfree = true;
                overlays = [ inputs.blender-bin.overlays.default ];
            };
            vesc_tool = inputs.vesc_tool-flake.packages.${system}.default;
            custom-pkgs = import ./modules/custom-pkgs.nix { inherit pkgs; };
        in {
        nixosConfigurations = {
            main = lib.nixosSystem {
                specialArgs = {
                    inherit pkgs-unstable;
                    inherit vesc_tool;
                    # inherit custom-pkgs;
                };
                modules = [
                    ./hosts/main/configuration.nix
                    ./modules/common.nix
                    ./modules/desktop.nix
                ];
            };
            work = lib.nixosSystem {
                specialArgs = {
                    inherit pkgs-unstable;
                };
                modules = [
                    ./hosts/work/configuration.nix
                    "${inputs.nixos-wsl}/modules"
                    ./modules/common.nix
                ];
            };
        };
        devShells.${system} = {
            blender = pkgs.mkShell {
                packages = [
                    (pkgs.python311.withPackages (ps: with ps; [
                        custom-pkgs.fake-bpy-module
                        pyside6
                        pip
                    ]))
                ];
            };
        };
    };
}
