{
  flake.modules.nixos.brave = {};

  flake.modules.homeManager.brave =
  { lib, pkgs, ... }:
  {
    programs.brave = {
      enable = true;
      extensions = [
      { id = "ekhaghlcjklgnkhnjgjajckwehhnlkeo"; } # Unhook
      ];
    };

    xdg.mimeApps = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      enable = true;
      defaultApplicationPackages = lib.mkAfter [ pkgs.brave ];
    };
  };
}
