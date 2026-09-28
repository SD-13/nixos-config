{
  flake.modules.nixos.boot = {
    boot = {
      consoleLogLevel = 0;
      kernelParams = [
        "quiet"
          "rd.udev.log_level=3"
      ];
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
        timeout = 0;
      };
    };

    systemd.services.plymouth-quit-wait.enable = false;
  };
}
