{
  flake.modules.generic.primaryUserHome =
    { config, ... }:
    {
      home-manager.users.${config.primaryUser}.home.stateVersion = "25.11";
    };
}
