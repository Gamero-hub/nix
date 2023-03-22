{pkgs, config, inputs, ...}: 
{
    environment.packages = [ # or home.packages
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-stable # installs a package
  ];
}