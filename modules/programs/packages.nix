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
        tor-browser
        alarm-clock-applet
        playwright
        kubernetes-helm
        k9s
        devenv
        antigravity
        qbittorrent
        vim
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    gcc
      gnumake
      unzip
      wl-clipboard
      slack
      zoom-us
    ];
  };
}
