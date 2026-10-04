{
  flake.modules.nixos.networking = {
    networking = {
      networkmanager.enable = true;
    };
    services.dnscrypt-proxy = {
      enable = true;
      settings = {
        server_names = [ "cloudflare" "9.9.9.9" "cloudflare-ipv6" "208.67.222.222" "208.67.220.220"];
      };
    };
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
