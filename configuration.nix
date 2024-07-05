# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# FOR HOME MANAGER use home.nix

{ inputs, lib, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/core.nix # basic packages
      ./modules/DE.nix # DE packages
      # NOTE: customize DE in home.nix!
      ./modules/user.nix # User packages/programs
      
      # ADDITIONALLY: Ensure user wallpaper is in ~/.background-image/wallpaper.whatever
      # and set it in home.nix stylix.
    ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
