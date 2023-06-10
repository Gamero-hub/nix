{
  description = "A very basic flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable"; 
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, spicetify-nix, ... }: 
    let
      system = "x86_64-linux"; 
      overlay-unstable = final: prev: {
#      unstable = nixpkgs-unstable.legacyPackages.${prev.system};
        unstable = import nixpkgs-unstable {
           inherit system;
           config.allowUnfree = true;
         };
        };
      lib = nixpkgs.lib;
    in {
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        virtland = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/virtland/configuration.nix 
            ./hosts/nixstuff
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pablo = {
                imports = [
                  ./users/pablo/home.nix
                ];
              };
            }
          ];
        };
        lowland = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/lowland/configuration.nix 
            ./hosts/nixstuff
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pablo = {
                imports = [
                  ./users/pablo/home.nix
                ];
              };
            }
          ];
        };
        highland = lib.nixosSystem {
          inherit system;
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
            ./hosts/highland/configuration.nix 
            ./hosts/nixstuff
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pablo = {
                imports = [
                  ./users/pablo/home.nix
                ];
              };
            }
          ];
        };
      };
    };
}
