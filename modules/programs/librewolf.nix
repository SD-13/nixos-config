{
  flake.modules.nixos.librewolf = {};

  flake.modules.homeManager.librewolf =
  { lib, pkgs, ... }:
  {
    programs.librewolf = {
      enable = true;
      policies = {
        Preferences = {
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown.history" = false;
        };
      };
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "network.cookie.lifetimePolicy" = 0;

# Define default fonts for different styles
        "font.name.sans-serif.x-western" = "Ubuntu Sans";
        "font.name.serif.x-western" = "Ubuntu";
        "font.name.monospace.x-western" = "UbuntuMono Nerd Font";

# Force fallback assignments
        "font.default.x-western" = "sans-serif";

# Set base font sizes (in pixels)
        "font.size.variable.x-western" = 14;
        "font.size.monospace.x-western" = 12;
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
