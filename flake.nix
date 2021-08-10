{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    rnix-lsp.url = "github:nix-community/rnix-lsp";
    grapejuice-patched.url = "github:shadowninja55/grapejuice-patched";
    dracula-nvim = {
      url = "github:Mofiqul/dracula.nvim";
      flake = false;
    };
    v-vim = {
      url = "github:ollykel/v-vim";
      flake = false;
    };
    dandellion = {
      url = "git+https://git.dodsorf.as/Dandellion/NUR";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, home-manager, nur, ... } @inputs: 
  let 
    system = "x86_64-linux";
    overlays = [
      (final: prev: {
        rnix-lsp = inputs.rnix-lsp.defaultPackage."${system}";
        grapejuice-patched = inputs.grapejuice-patched.defaultPackage."${system}";
        vimPlugins = prev.vimPlugins // {
          dracula-nvim = prev.vimUtils.buildVimPlugin {
            name = "dracula.nvim";
            src = inputs.dracula-nvim;
          };
          v-vim = prev.vimUtils.buildVimPlugin {
            name = "v-vim";
            src = inputs.v-vim;
          };
        };
        nur = import nur {
          nurpkgs = prev;
          pkgs = prev;
          repoOverrides.dandellion = import inputs.dandellion { pkgs = prev; };
        };
      })
    ]; in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
        inherit system;
        specialArgs = {
          inherit nixpkgs;
        };
        modules = [
          { 
            nixpkgs = { 
              inherit overlays; 
              config.allowUnfree = true;
            }; 
          }
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
