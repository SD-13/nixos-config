{
  flake.modules.nixos.navidrome = {
    services.navidrome = {
      enable = true;
      openFirewall = true;
      settings = {
        MusicFolder = "/mnt/songs/music/";
        Address = "0.0.0.0";
      };
    };
  };
}
