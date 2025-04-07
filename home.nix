{ config, pkgs, inputs, ... }:

{
  imports = with inputs; [
    nixvim.homeManagerModules.nixvim
    gauntlet.homeManagerModules.default
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mridula";
  home.homeDirectory = "/home/mridula";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
      git
      wl-clipboard
      hyprland
      kitty
      hyprpaper
      starship
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      exec-once = ["gauntlet"];
      general = {
       border_size = "0";
       gaps_in = "5";
       gaps_out = "5";
      };
      decoration = {
        rounding = "10";
        blur.enabled = "false";
      };
      "$mod" = "ALT";
      bind = [
        # Apps
        "$mod, SPACE, exec, gauntlet open"
        "$mod, C, killactive"
        "$mod, F, exec, flatpak run app.zen_browser.zen"
        "$mod, E, exec, dolphin"
        "$mod, Q, exec, kitty"

        # Navigation
         "$mod, H, movefocus, l"
         "$mod, J, movefocus, d"
         "$mod, K, movefocus, u"
         "$mod, L, movefocus, r"
        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
 
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "/etc/nixos/wallpaper.jpg";
      wallpaper = ",/etc/nixos/wallpaper.jpg";
    };
  };
  programs = {
    bash = {
      enable = true;
      shellAliases = {
        c = "cd /etc/nixos/nixos-backup";
        r = "reload";
      };
    };
    kitty = {
      enable = true;
      extraConfig = ''
        background_opacity 0.5
        confirm_os_window_close 0
      '';
    };
    git = {
      enable = true;
      userName = "Mrid22";
      userEmail = "mridulaga@outlook.com";
    };
    lazygit = {
      enable = true;
    };
    nixvim = {
      config = {
        enable = true;
	viAlias = true;
	vimAlias = true;
	keymaps = [
          {
            key = "<Space>e";
	    action.__raw = "function() Snacks.explorer() end";
	    mode = "n";
	  }
	  {
            key = "<Space>t";
	    action.__raw = "function() Snacks.terminal() end";
	    mode = "n";
	  }
	  {
            key = "<Space>g";
	    action.__raw = "function() Snacks.lazygit() end";
	    mode = "n";
	  }
	];
	colorschemes.tokyonight = {
          enable = true;
	  settings = {
            transparent = true;
	    styles = {
	      floats = "transparent";
	      sidebars = "transparent";
	    };
	  };
	};
	plugins = {
	  lualine = {
            enable = true;
	  };
	  treesitter = {
	    enable = true;
            settings = {
	      auto_install = true;
              highlight = { enable = true; };
	    };
	  };
	  snacks = {
	    enable = true;
	    settings = {
              explorer = {
                enable = true;
	      };
	      indent = {
                enable = true;
	      };
	      git = {
               enable = true;
	      };
	      lazygit = {
                enable = true;
	      };
	      terminal = {
                enable = true;
	      };
	    };
	  };
	};
      };
    };
    gauntlet = {
      enable = true;
      service.enable = true;
      config = {};
    };
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
  #  /etc/profiles/per-user/mridula/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    SUDO_EDITOR = "nvim";
    NR_CORES = 20;
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
