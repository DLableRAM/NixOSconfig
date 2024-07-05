# Core system packages
{ inputs, lib, config, pkgs, ... }:

{
  imports = [ ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    home-manager
    kitty
    nh
    wirelesstools
    lynx
    searxng
    killall
    remmina
  ];

  # Searx config
  services.searx = {
    enable = true;
    settings = {
      server = {
        port = 8888;
        bind_address = "127.0.0.1";
        secret_key = "secret key";
      };
    };
  };

  # Nh config
  programs.nh = {
    enable = true;
    flake = "/home/michael/NixOSconfig";
  };

  # SSH config
  services.openssh = {
    enable = true;
    settings.X11Forwarding = true;
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.openssh;
  };

  # Nvidia config
  hardware = {
    opengl.enable = true;
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Server specialisation
  specialisation = {
    server.configuration = {
      services.openssh.ports = [ 22 ];
      services.xrdp = {
        enable = true;
	openFirewall = true;
	defaultWindowManager = "i3";
      };
    };
  };
}
