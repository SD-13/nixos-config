{ inputs, config, ... }:
let
  inherit (config.flake.modules) nixos;
in
{
  configurations.nixos.xps.module = {
    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-intel
      inputs.nixos-hardware.nixosModules.common-pc-laptop
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      ./_hardware.nix
      nixos.base
      nixos.hyprland
    ];

    primaryUser = "jack";
    system.stateVersion = "25.11";

    services.thermald.enable = true;
  };
}
