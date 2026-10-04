{ inputs, pkgs, ... }:
{
  flake.modules.nixos.librewolf = {};

  flake.modules.homeManager.librewolf =
  { lib, pkgs, ... }:
  {

    programs.librewolf = {
      enable = true;
      package = inputs.nixpkgs-librewolf.legacyPackages.${pkgs.stdenv.hostPlatform.system}.librewolf;
      settings = {
        "privacy.clearOnShutdown.cookies" = false;  # Disables global cookie clearing on close
          "privacy.clearOnShutdown.history" = false;  # (Optional) Stops history from wiping if needed
          "network.cookie.lifetimePolicy" = 0;
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = true;
        "privacy.fingerprintingProtection" = true;
      };
      policies = {
        ExtensionSettings = {
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
          "myallychou@gmail.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-recommended-videos/latest.xpi";
            installation_mode = "force_installed";
          };
        };
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
