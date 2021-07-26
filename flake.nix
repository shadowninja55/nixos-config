{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    rnix-lsp-git.url = "github:nix-community/rnix-lsp";
  };
  outputs = { self, nixpkgs, home-manager, nur, rnix-lsp-git, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit nixpkgs rnix-lsp-git;
      };
      modules = [
        { nixpkgs.overlays = [ nur.overlay ]; }
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
