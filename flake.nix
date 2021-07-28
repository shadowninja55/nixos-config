{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    rnix-lsp.url = "github:nix-community/rnix-lsp";
  };;
  outputs = { self, nixpkgs, home-manager, nur, ... } @inputs: 
  let 
    system = "x86_64-linux";
    overlays = [
      nur.overlay
      (final: prev: {
        rnix-lsp = inputs.rnix-lsp.defaultPackage.${system};
      })
    ]; in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
        inherit system;
        specialArgs = {
          inherit nixpkgs;
        };
        modules = [
          { nixpkgs = { inherit overlays; }; }
          ({ pkgs, ... }:
          let
            nur-no-pkgs = import nur {
              nurpkgs = import nixpkgs { system = "x86_64-linux"; };
            };
          in {
            imports = [ nur-no-pkgs.repos.kira-bruneau.modules.lightdm-webkit2-greeter ];
          }
          )
          ./system.nix
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
