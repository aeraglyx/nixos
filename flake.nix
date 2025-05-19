{
    description = "Aeraglyx's Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    };

    outputs = { nixpkgs, nixpkgs-unstable, ... }:
        let
            system = "x86_64-linux";
            lib = nixpkgs.lib;
            # pkgs = nixpkgs.legacyPackages.${system};
            pkgs-unstable = import nixpkgs-unstable {
                system = system;
                config.allowUnfree = true;
            };
        in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                specialArgs = {
                    inherit pkgs-unstable;
                };
                modules = [ ./configuration.nix ];
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
