
{
  description = "A very basic flake";

  inputs = {
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = github:the-argus/spicetify-nix;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
      system = "x86_64-linux"; 
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        virtland = lib.nixosSystem {
          inherit system;
          modules = [ 
          ./hosts/virtland/configuration.nix 
          home-manager.nixosModules.home-manager {
           home-manager.useGlobalPkgs = true;
           home-manager.useUserPackages = true;
           home-manager.users.pablo = {
             imports = [ ./users/pablo/home.nix];
          };
        }
          ];
        };
        lowland = lib.nixosSystem {
          inherit system;
          modules = [ 
          ./hosts/lowland/configuration.nix 
          home-manager.nixosModules.home-manager {
           home-manager.useGlobalPkgs = true;
           home-manager.useUserPackages = true;
           home-manager.users.pablo = {
             imports = [ ./users/pablo/home.nix];
          };
        }
          ];
        };           
        highland = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/highland/configuration.nix ];
        };
      };
    };
}