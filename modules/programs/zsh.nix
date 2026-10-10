{
  flake.modules.nixos.zsh =
  { config, pkgs, ... }:
  {
    programs.zsh.enable = true;
    users.users.${config.primaryUser}.shell = pkgs.zsh;
  };

  flake.modules.homeManager.zsh =
  {
    lib,
    pkgs,
    ...
  }:
  {
    catppuccin.zsh-syntax-highlighting.enable = false;

    programs.zsh = {
      enable = true;
      defaultKeymap = "viins";
      initContent = lib.optionalString pkgs.stdenv.hostPlatform.isLinux ''
        open() {
          xdg-open "$@" </dev/null >/dev/null 2>&1 &!
        }
        autoload -Uz +X compinit && compinit

        ## case insensitive path-completion
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' menu select
      '';
    };
  };
}
