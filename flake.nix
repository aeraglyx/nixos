{
    description = "Aeraglyx's Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        vesc_tool-flake.url = "github:lukash/vesc_tool-flake";
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
            };
            vesc_tool = inputs.vesc_tool-flake.packages.${system}.default;
            custom-pkgs = import ./custom-pkgs.nix { inherit pkgs; };
        in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                specialArgs = {
                    inherit pkgs-unstable;
                    inherit vesc_tool;
                    # inherit custom-pkgs;
                };
                modules = [
                    ./configuration.nix
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
