{
  flake.modules.nixos.zsh =
    {
      programs.localsend = {
        enable = true;
        openFirewall = true;
      };
    };
}
