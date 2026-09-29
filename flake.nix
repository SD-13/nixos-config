{
  description = "NixOS configs for my machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # noctalia-greeter = {
    #   url = "github:noctalia-dev/noctalia-greeter/v1.5.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    #
    # noctalia = {
    #   url = "github:noctalia-dev/noctalia/v5.0.1";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    #
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-palette = {
      url = "github:catppuccin/palette";
      flake = false;
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        (inputs.import-tree ./modules)
      ];
    };
}
