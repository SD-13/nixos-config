{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
      openFirewall = true;
# settings = {
#   PasswordAuthentication = false;
#   KbdInteractiveAuthentication = false;
#   PermitRootLogin = "no";
#   AllowUsers = [ "jack" ];
#   MaxAuthTries = 3;
#   PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
# };
    };
    programs.ssh = {
      extraConfig = ''
        Host work
        Hostname 192.168.0.100
        Port 22
        User jack
        '';
    };
  };
}
