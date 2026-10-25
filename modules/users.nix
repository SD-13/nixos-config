{
  flake.modules.nixos.users =
  {
    config,
    ...
  }:
  {
    users.users.${config.primaryUser} = {
      description = config.profile.fullName;
      extraGroups = [
        "networkmanager"
          "video"
          "wheel"
      ];
      isNormalUser = true;
    };
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "jack" ];

    security.sudo.wheelNeedsPassword = false;
  };

}
