{
  description = "A very basic flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };
  
  outputs = { self, nixpkgs, home-manager, spicetify-nix, ... }: 
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
            ./hosts/nixstuff
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pablo = {
                imports = [
                  ./users/pablo/home.nix
                  ./users/pablo/programs/spicetify-nix.nix
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
                  ./users/pablo/programs/spicetify-nix.nix
                ];
              };
            }
          ];
        };
        highland = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/highland/configuration.nix 
            ./hosts/nixstuff
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pablo = {
                imports = [
                  ./users/pablo/home.nix
                  ./users/pablo/programs/spicetify-nix.nix
                ];
              };
            }
          ];
        };
      };
    };
}
