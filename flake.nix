{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rnix-lsp.url = "github:nix-community/rnix-lsp";
    grapejuice-patched.url = "github:shadowninja55/grapejuice-patched";
  };
  outputs = { self, nixpkgs, home-manager, ... } @inputs: 
  let 
    system = "x86_64-linux";
    overlays = [
      (final: prev: {
        rnix-lsp = inputs.rnix-lsp.defaultPackage.${system};
        grapejuice-patched = inputs.grapejuice-patched.defaultPackage.${system};
      })
    ]; in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
        inherit system;
        specialArgs = {
          inherit nixpkgs;
        };
        modules = [
          { nixpkgs = { inherit overlays; }; }
          ./system
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mark = import ./home;
            };
          }
        ];
      };
    };
  }
