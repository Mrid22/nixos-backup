{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = with inputs; [
    gauntlet.homeManagerModules.default
    nvf.homeManagerModules.default
  ];

  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    packages = with pkgs; [
      git
      wl-clipboard
      xsel
      hyprland
      hyprpaper
      hyprlock
      kitty
      starship
      mako
      swaynotificationcenter
      prettierd
      waybar
      prismlauncher
      nodejs_23
      pnpm
      spotube
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      exec-once = ["gauntlet" "waybar"];
      general = {
        border_size = "0";
        gaps_in = "5";
        gaps_out = "5";
      };
      decoration = {
        rounding = "10";
        blur.enabled = "false";
      };
      animations = {
        enabled = "yes, please :)";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, slide"
          "workspacesIn, 1, 1.21, almostLinear, slide"
          "workspacesOut, 1, 1.94, almostLinear, slide"
        ];
      };
      input = {
        touchpad = {
          natural_scroll = true;
        };
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

        # Volume and Brightness
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "/etc/nixos/nixos-backup/wallpaper.jpg";
      wallpaper = ",/etc/nixos/nixos-backup/wallpaper.jpg";
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Layan-Dark";
      package = pkgs.layan-gtk-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  programs = {
    bash = {
      enable = true;
      shellAliases = {
        c = "cd /etc/nixos/nixos-backup";
        r = "reload";
        u = "update";
        g = "autogit";
      };
    };
    kitty = {
      enable = true;
      extraConfig = ''
        background_opacity 0.25
        confirm_os_window_close 0
      '';
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "$line_break"
          "$package"
          "$line_break"
          "$character"
        ];
        scan_timeout = 10;
        character = {
          success_symbol = "➜";
          error_symbol = "➜";
        };
      };
    };
    git = {
      enable = true;
      userName = "Mrid22";
      userEmail = "mridulaga@outlook.com";
    };
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          height = 30;
          spacing = 4;
          modules-left = [
            "hyprland/workspaces"
            "hyprland/mode"
          ];
          modules-center = [
            "hyprland/window"
          ];
          modules-right = [
            "idle_inhibitor"
            "pulseaudio"
            "network"
            "battery"
            "clock"
          ];
          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };
        };
      };
      style = ''
        window#waybar {
          background-color: rgba(0, 0, 0, 0.5);
          border-radius: 0px;
          padding: 5px;
        }
      '';
    };
    hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
        };
        background = {
          path = "wallpaper.jpg";
        };
        input-field = {
          size = "300, 60";
          outline_thickness = 0;
          inner_color = "rgba(0,0,0,0.5)";
          fade_on_empty = false;
        };
      };
    };
    lazygit = {
      enable = true;
    };
    gauntlet = {
      enable = true;
      service.enable = true;
      config = {};
    };
    nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;
          # Settings
          lineNumberMode = "none";
          globals = {
            mapleader = " ";
          };
          options = {
            tabstop = 2;
            shiftwidth = 2;
            mouse = "v";
          };
          # Plugins
          assistant = {
            copilot = {
              enable = true;
              cmp.enable = true;
            };
            codecompanion-nvim = {
              enable = true;
              setupOpts = {
                display = {
                  start_in_insert_mode = true;
                  chat = {
                    show_token_count = true;
                  };
                };
              };
            };
          };
          dashboard = {
            alpha = {
              enable = true;
              theme = "dashboard";
            };
          };
          keymaps = [
            {
              key = "<leader>e";
              mode = "n";
              action = ":Neotree<CR>";
            }
            {
              key = "<leader>c";
              mode = "n";
              action = ":CodeCompanionChat<CR>";
            }
            {
              key = "<leader>u";
              mode = "n";
              action = ":Update<CR>";
            }
            {
              key = "<leader>g";
              mode = "n";
              action = ":AutoGit<CR>";
            }
          ];
          statusline.lualine.enable = true;
          autopairs.nvim-autopairs.enable = true;
          autocomplete.nvim-cmp.enable = true;
          telescope = {
            enable = true;
            mappings = {
              buffers = "<leader>fb";
            };
          };
          terminal.toggleterm = {
            enable = true;
            lazygit = {
              enable = true;
            };
            mappings = {
              open = "<leader>t";
            };
          };
          theme = {
            enable = true;
            name = "tokyonight";
            style = "storm";
            transparent = true;
            extraConfig = ''
              opts = {
                styles = {
                  sidebars = "transparent",
                  floats = "transparent",
                };
              }
            '';
          };
          comments = {
            comment-nvim.enable = true;
          };
          debugger = {
            nvim-dap = {
              enable = true;
              ui = {
                enable = true;
                autoStart = true;
              };
              mappings = {
                continue = "<leader>dc";
                toggleBreakpoint = "<leader>dt";
              };
            };
          };
          spellcheck.enable = true;
          visuals = {
            nvim-web-devicons.enable = true;
          };
          filetree = {
            neo-tree = {
              enable = true;
            };
          };
          git.enable = true;
          notify.nvim-notify.enable = true;
          treesitter = {
            enable = true;
            autotagHtml = true;
            fold = true;
            indent.enable = true;
            highlight.enable = true;
          };
          languages = {
            enableLSP = true;
            enableFormat = true;
            enableTreesitter = true;
            enableDAP = true;

            bash.enable = true;
            css.enable = true;
            html.enable = true;
            markdown = {
              enable = true;
              extensions = {
                render-markdown-nvim.enable = true;
              };
            };
            nix.enable = true;
            python = {
              enable = true;
              format.type = "black-and-isort";
            };
            rust.enable = true;
            tailwind.enable = true;
            ts = {
              enable = true;
              extensions = {
                ts-error-translator.enable = true;
              };
            };
            yaml.enable = true;
          };
          lsp = {
            formatOnSave = true;
            inlayHints.enable = true;
            lspkind.enable = true;
            lightbulb.enable = true;
            trouble.enable = true;
            mappings = {
              codeAction = "<leader>ca";
              renameSymbol = "<leader>rn";
            };
          };
          ui = {
            colorizer = {
              enable = true;
              setupOpts = {
                user_default_options = {
                  tailwind = true;
                };
              };
            };
          };
        };
      };
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
    EDITOR = "nvim";
    NR_CORES = 20;
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
