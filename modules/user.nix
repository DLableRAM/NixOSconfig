# Define users
{ lib, config, pkgs, ... }:

{
  imports = [ ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.michael = {
    isNormalUser = true;
    description = "michael";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Steam
  # I don't know why it cannot be installed in the user space via HM but here we are.
  programs.steam.enable = true;
}
