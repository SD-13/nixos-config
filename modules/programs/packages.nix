{ inputs, ... }:
{
  flake.modules.homeManager.packages =
    {
      lib,
      pkgs,
      ...
    }:
    {
      home.packages =
        with pkgs;
        [
          fd
          jq
          nh
          pipenv
          python3
          ripgrep
          telegram-desktop
        ]
        ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
          gcc
          gnumake
          unzip
          wl-clipboard
        ];
    };
}
