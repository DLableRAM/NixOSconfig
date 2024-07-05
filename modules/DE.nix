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
}
