{
  flake.modules.nixos.librewolf = {};

  flake.modules.homeManager.librewolf =
  { lib, pkgs, ... }:
  {
    programs.librewolf = {
      enable = true;
      settings = {
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.history" = false;
        "network.cookie.lifetimePolicy" = 0;
      };
    };

    xdg.mimeApps = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      enable = true;
      defaultApplicationPackages = [
        pkgs.librewolf
      ];
    };
  };
}
