{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    # Input flakes
    inputs.nixvim.homeManagerModules.nixvim
    inputs.stylix.homeManagerModules.stylix
  ];
  
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "michael";
  home.homeDirectory = "/home/michael";
  
  # GTK config
  gtk = {
    enable = true;
  };

  # QT config
  qt.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.yazi
    pkgs.picom
    pkgs.ollama
    pkgs.fastfetch
    pkgs.distrobox
    pkgs.brightnessctl
    pkgs.pavucontrol
    pkgs.rofi
    pkgs.xclip
    pkgs.flameshot
    pkgs.pinta
    pkgs.qutebrowser
    pkgs.betterbird
    pkgs.freetube
    pkgs.element-desktop
    pkgs.lshw
  ];

  # Qutebrowser config
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      DEFAULT = "127.0.0.1:8888/search?q={}";
    };
    settings = {
      url.start_pages = "127.0.0.1:8888";
      colors.webpage.darkmode = {
        algorithm = "brightness-rgb";
	enabled = true;
	policy.images = "never";
      };
    };
  };

  # i3 config
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "rofi -show combi -combi-modes \'window#drun#ssh\' -modes combi";
      bars = [];
      window = {
        titlebar = false;
      };
      gaps = {
        inner = 10;
        outer = 5;
      };
    };
    extraConfig = ''
    exec_always killall polybar
    exec_always polybar
    exec_always betterbird
    '';
  };

  # Picom config
  services.picom = {
    enable = true;
    inactiveOpacity = 0.8;
  };

  # rofi config
  programs.rofi = {
    enable = true;
    terminal = "kitty";
  };

  # polybar config
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
    };
    script = "polybar main &";
    settings = {
      "bar/main" = {
        modules.left = "tray";
        modules.center = "i3";
        modules.right = "network battery date";
        module.margin = "4";
        background = config.lib.stylix.colors.base00;
        foreground = config.lib.stylix.colors.base05;
      };
      "module/tray" = {
        type = "internal/tray";
      };
      "module/i3" = {
        type = "internal/i3";
      };
      "module/battery" = {
        type = "internal/battery";
      };
      "module/date" = {
        type = "internal/date";
        date = "%Y-%m-%d%";
        time = "%H:%M";
	label = "%time%";
      };
      "module/network" = {
        type = "internal/network";
        interface = "wlp0s20f3";
      };
    };
  };

  # Kitty config
  programs.kitty = {
    enable = true;
    extraConfig = ''
    background_opacity 0.6
    '';
  };

  # Nixvim config
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    #colorschemes.gruvbox.enable = true;
    plugins = {
      lualine.enable = true;
      bufferline.enable = true;
      lsp = {
        enable = true;
	servers = {
	  clangd.enable = true;
	  ruff-lsp.enable = true;
	};
      };
      treesitter.enable = true;
      treesitter-context.enable = true;
      treesitter-refactor.enable = true;
      treesitter-textobjects.enable = true;
      jupytext.enable = true;
      lazygit.enable = true;
      cmp = {
        enable = true;
	autoEnableSources = true;
	settings.sources = [
	  {name = "nvim_lsp";}
	  {name = "path";}
	  {name = "buffer";}
	];
	settings = {
	  mapping = {
	    "<C-Space>" = "cmp.mapping.complete()";
	    "<C-d>" = "cmp.mapping.scroll_docs(-4)";
	    "<C-e>" = "cmp.mapping.close()";
	    "<C-f>" = "cmp.mapping.scroll_docs(4)";
	    "<CR>" = "cmp.mapping.confirm({ select = true })";
	    "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
	    "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
	  };
	};
      };
      telescope = {
        enable = true;
	extensions = {
	  file-browser.enable = true;
	  ui-select.enable = true;
	};
      };
      oil.enable = true;
      luasnip.enable = true;
      notify.enable = true;
      neotest = {
	enable = true;
	adapters.plenary.enable = true;
      };
      ollama = {
        enable = true;
	model = "codegemma:2b";
	url = "http://192.168.1.189:11434";
      };
      wilder = {
        enable = true;
      };
    };
  };

  # Stylix config
  stylix = {
    enable = true;
    autoEnable = true;
    image = /home/michael/.background-image/wallpaper.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
    polarity = "dark";
  };
  
  # Git config
  git = {
    enable = true;
    userName = "DLableRAM";
    userEmail = "spac3core24@gmail.com";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/michael/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
