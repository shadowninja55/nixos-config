{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rnix-lsp.url = "github:nix-community/rnix-lsp";
    dracula-nvim = {
      url = "github:mofiqul/dracula.nvim";
      flake = false;
    };
    v-vim = {
      url = "github:ollykel/v-vim";
      flake = false;
    };
    nest-nvim = {
      url = "github:lionc/nest.nvim";
      flake = false;
    };
    powercord-overlay.url = "github:lavadesu/powercord-overlay";
    dracula-powercord = {
      url = "github:slowstab/dracula";
      flake = false;
    };
    dyalog-nixos = {
      url = "github:markus1189/dyalog-nixos";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, home-manager, ... } @inputs: 
  let 
    system = "x86_64-linux";
    overlays = [
      (final: prev: {
        rnix-lsp = inputs.rnix-lsp.defaultPackage."${system}";
        vimPlugins = prev.vimPlugins // {
          dracula-nvim = prev.vimUtils.buildVimPlugin {
            name = "dracula.nvim";
            pname = "dracula-nvim";
            src = inputs.dracula-nvim;
          };
          v-vim = prev.vimUtils.buildVimPlugin {
            name = "v-vim";
            pname = "v-vim";
            src = inputs.v-vim;
          };
          nest-nvim = prev.vimUtils.buildVimPlugin {
            name = "nest.nvim";
            pname = "nest-nvim";
            src = inputs.nest-nvim;
          };
        };
      })
      inputs.powercord-overlay.overlay
      (import "${inputs.dyalog-nixos}/overlay.nix")
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
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
        ];
      };
    };
  }
