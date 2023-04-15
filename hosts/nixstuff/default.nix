{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./blocker.nix
    ./pkgs.nix
  ];
}
