{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nix-gaming.url = "github:fufexan/nix-gaming";
    wallpkgs = wallpkgs.packages.x86_64-linux.catppuccin;
    hyprland = {
      url = github:hyprwm/Hyprland;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, nixpkgs-f2k, hyprland, wallpkgs, ... } @inputs:
    let
      system = "x86_64-linux";
      inherit (self) outputs;
      lib = nixpkgs.lib;
    in
    {
      home.packages = [ wallpkgs ];
      nixosConfigurations = {
        lowland = lib.nixosSystem {
          inherit system; 
	  specialArgs = {
		inherit inputs outputs home-manager;
	       };
          modules = [
            ./hosts/lowland/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pablo = {
                imports = [
                  ./home/pablo/home.nix
                ];
              };
            }
          ];
        };
        highland = lib.nixosSystem {
          inherit system;
	    specialArgs = {
		inherit inputs outputs home-manager;
	       };
          modules = [
            ./hosts/highland/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pablo = {
                imports = [
                  ./home/pablo/home.nix
                ];
              };
            }
          ];
        };
      };
    };
}
