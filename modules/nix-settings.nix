{ inputs, ... }:
{
  flake.modules.generic.nixSettings = {
    nixpkgs.config.allowUnfree = true;

    nix = {
      channel.enable = false;
      nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
        experimental-features = [
          "nix-command"
            "flakes"
        ];
      };

      optimise.automatic = true;
    };
  };
}
