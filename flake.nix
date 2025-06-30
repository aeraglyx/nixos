{
    description = "Aeraglyx's Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        vesc_tool-flake.url = "github:lukash/vesc_tool-flake";
        # blender-bin.url = "github:edolstra/nix-warez?dir=blender";
    };

    outputs = { nixpkgs, nixpkgs-unstable, ... } @ inputs:
        let
            system = "x86_64-linux";
            lib = nixpkgs.lib;
            # pkgs = nixpkgs.legacyPackages.${system};
            pkgs-unstable = import nixpkgs-unstable {
                system = system;
                config.allowUnfree = true;
            };
            vesc_tool = inputs.vesc_tool-flake.packages.${system}.default;
        in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                specialArgs = {
                    inherit pkgs-unstable;
                };
                modules = [
                    ./configuration.nix
                    { environment.systemPackages = [ vesc_tool ]; }
                    # ({config, pkgs, ...}: { nixpkgs.overlays = [ inputs.blender-bin.overlays.default ]; })
                ];
            };
        };
        # devShells.${system} = {
        #     blender = pkgs.mkShell {
        #         packages = [
        #             (pkgs.python314.withPackages (python-pkgs: with python-pkgs; [
        #                 pynvim
        #             ]))
        #         ];
        #     };
        # };
    };
}
