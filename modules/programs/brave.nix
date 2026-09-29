{
  flake.modules.nixos.brave = {};

  flake.modules.homeManager.brave =
    { lib, pkgs, ... }:
    {
      programs.brave.enable = true;

      xdg.mimeApps = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
        enable = true;
        defaultApplicationPackages = lib.mkAfter [ pkgs.brave ];
      };
    };
}
