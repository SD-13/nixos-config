{ config, ... }:
let
  inherit (config.flake.modules)
    generic
    nixos
    homeManager
    ;
  commonImports = [
    generic.homeManagerIntegration
    generic.nixSettings
    generic.primaryUser
    generic.primaryUserHome
    generic.profile
  ];
in
{
  flake.modules.generic.homeManagerIntegration = {
    home-manager = {
      backupFileExtension = "backup";
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = [ homeManager.base ];
    };
  };

  flake.modules.nixos.base = {
    imports = commonImports ++ [
      nixos.audio
      nixos.bluetooth
      nixos.boot
      nixos.locale
      nixos.networking
      nixos.users
      nixos.zsh
    ];
  };

  flake.modules.homeManager.base = {
    imports = [
      generic.profile
      # homeManager.alacritty
      homeManager.atuin
      homeManager.aws
      homeManager.bat
      homeManager.btop
      homeManager.catppuccin
      homeManager.eza
      homeManager.fastfetch
      homeManager.fonts
      homeManager.foot
      homeManager.fzf
      homeManager.git
      homeManager.go
      homeManager.gpg
      homeManager.k8s
      homeManager.neovim
      homeManager.opencode
      homeManager.packages
      homeManager.starship
      homeManager.tmux
      homeManager.xdg
      homeManager.zsh
    ];
  };
}
