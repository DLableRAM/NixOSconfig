# Module for WM/DE/compositor management
# IE xserver
{ lib, config, pkgs, ... }:

{
  imports = [ ];

  services.displayManager.sddm = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager.defaultSession = "none+i3";
    videoDrivers = ["nvidia"];
    windowManager.i3 = {
      enable = true;
    };
  };

  # Extra config for laptop/non configurable keyboard
  specialisation = {
    laptop.configuration = {
      services.xserver = {
        layout = "us";
        xkbVariant = "dvorak";
	resolutions = [ {
          x = 1920;
          y = 1080;
        } ];
      };
      systemd.targets.sleep.enable = false;
      systemd.targets.suspend.enable = false;
      systemd.targets.hibernate.enable = false;
      systemd.targets.hybrid-sleep.enable = false;
      hardware.nvidia.prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:3:0:0";
      };
    };
  };
}
