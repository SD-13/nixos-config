{ inputs, config, ... }:
let
inherit (config.flake.modules) homeManager nixos;
in
{
  flake.modules.nixos.hyprland = {
    hardware.graphics.enable = true;
# imports = [
#   nixos.desktopApps
# ];

    home-manager.sharedModules = [ homeManager.hyprland ];

    services = {
      xserver.enable = true;
      displayManager.sddm.enable = true;
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };

    programs = {
# noctalia.enable = true;
      hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
      };
    };
  };

  flake.modules.homeManager.hyprland =
  {
    config,
    lib,
    pkgs,
    ...
  }:
  {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      package = null;
      portalPackage = null;
      configType = "lua";

      settings = {
        # exec-once = "noctalia";
        decoration = {
          shadow_offset = "0 5";
          "col.shadow" = "rgba(00000099)";
        };

        "$mod" = "SUPER";

        bind = [
# Execute Rofi with only the SUPER key
          "$mod, Super_L, exec, pkill rofi || rofi -show drun"

            "$mod, F, exec, librewolf"

            "CONTROL ALT, T, exec, wezterm"
        ];

        bindm = [
# mouse movements
          "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
            "$mod ALT, mouse:272, resizewindow"
        ];
      };

      extraConfig = ''

        hl.config({
            input = {
            kb_layout = "gb",
            },
            xwayland = {
            force_zero_scaling = true,
            },
            general = {
            layout = "master",
            border_size = 2,
            gaps_in = 0,
            gaps_out = 0,
            col = {
            active_border = "rgba(ffffffff)",
            inactive_border = "rgba(1a1a1aff)",
            },
            },
            master = {
            orientation = "left",
            allow_small_split = true,
            mfact = 0.5,
            },
            decoration = {
              rounding = 5,
              rounding_power = 10,
              active_opacity = 1.0,
              inactive_opacity = 1.0,
              dim_special = 0.5,
              blur = {
                enabled = false,
              },
              shadow = {
                enabled = false,
              },
            },
            misc = {
              disable_hyprland_logo = true,
              disable_splash_rendering = true,
              render_unfocused_fps = 1,          
            },
        })

      hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

        hl.on("hyprland.start", function()
            hl.exec_cmd("noctalia")
            end)

        hl.window_rule({ match = { class = "^(thunar|Thunar)$", title = "Preferences" }, float = true, center = true, size = { 550, 500 } })
        hl.window_rule({ match = { class = "^(thunar|Thunar)$", title = "^(Rename.*)$" }, float = true, move = {"cursor_x-(window_w*0.5)", "cursor_y-(window_h*0.5)"} , size = { 300, 100 } })
        hl.window_rule({ match = { class = "firefox", title = ".*Save.*" }, float = true, center = true })
        hl.window_rule({ match = { class = "firefox", title = ".*Open.*" }, float = true, center = true })
        hl.window_rule({ match = { class = "DesktopEditors", float = true }, float = true, center = true })
        hl.window_rule({ match = { class = "xdg-desktop-portal-gtk", title = ".*Open.*" }, size = {"monitor_w * 0.5", "monitor_h * 0.5"}, float = true, center = true })
        hl.window_rule({ match = { class = "xdg-desktop-portal-gtk", title = ".*Open.*" }, size = {"monitor_w * 0.5", "monitor_h * 0.5"}, float = true, center = true })
        hl.workspace_rule({ workspace = "special:scratchpad", layout = "scrolling", gaps_out = 40, gaps_in = 20})

        hl.curve("fast", { type = "bezier", points = { {0, 1}, {0, 1} } })
        hl.curve("out", { type = "bezier", points = { {1, 1}, {1, 1} } })
        hl.curve("in", { type = "bezier", points = { {0, 1}, {1, 1} } })

        hl.animation({ leaf = "global", enabled = true, speed = 5, bezier = "fast" })
        hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "fast", style = "slide" })
        hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "fast", style = "slide" })
        hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "out", style = "slide" })
        hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "fast" })
        hl.animation({ leaf = "fade", enabled = false })
        hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "in", style = "slide" })
        hl.animation({ leaf = "layers", enabled = true, speed = 5, bezier = "fast", style = "slide" })
        hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "in", style = "slidefadevert 100%"})

        hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("foot"))
        hl.bind("SUPER + Q", hl.dsp.window.close())
        hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
        hl.bind("ALT + TAB", hl.dsp.exec_cmd("noctalia msg window-switcher"))
        hl.bind("SUPER + E", hl.dsp.exec_cmd("thunar"))
        hl.bind("SUPER + D", hl.dsp.focus({ workspace = "empty" }))
        hl.bind("SUPER + SHIFT + D", hl.dsp.window.move({ workspace = "empty" }))
        hl.bind("SUPER + L", hl.dsp.exec_cmd("noctalia msg session lock"))
        hl.bind("SUPER + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
        hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
        hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
        hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "+1" }))
        hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "-1" }))
        hl.bind("SUPER + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "+1" }))
        hl.bind("SUPER + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "-1" }))
        hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("scratchpad"))
        hl.bind("SUPER + SHIFT +S", hl.dsp.window.move({ workspace = "special:scratchpad" }))

        local function layout_bind(bind_table)
        return function ()
        local workspace = hl.get_active_special_workspace() or
        hl.get_active_workspace()
        if not workspace then
          return
            end
            local layout = workspace.tiled_layout           
            if bind_table[layout] then
              hl.dispatch(bind_table[layout])
                end
                end
                end

                hl.bind("SUPER + comma", layout_bind({
                      master    = hl.dsp.layout("mfact -0.01"),
                      scrolling = hl.dsp.layout("colresize -0.01"),    
                      }), { repeating = true })

      hl.bind("SUPER + period", layout_bind({
            master    = hl.dsp.layout("mfact +0.01"),
            scrolling = hl.dsp.layout("colresize +0.01"),    
            }), { repeating = true })

      hl.bind("SUPER + SHIFT + comma", layout_bind({
            master    = hl.dsp.layout("orientationprev"),
            scrolling = hl.dsp.layout("swapcol l"),    
            }))

      hl.bind("SUPER + SHIFT + period", layout_bind({
            master    = hl.dsp.layout("orientationnext"),
            scrolling = hl.dsp.layout("swapcol r"),    
            }))

      hl.bind("SUPER + slash", layout_bind({
            master    = hl.dsp.layout("addmaster"),
            scrolling = hl.dsp.layout("consume"),    
            }))

      hl.bind("SUPER + SHIFT + slash", layout_bind({
            master    = hl.dsp.layout("removemaster"),
            scrolling = hl.dsp.layout("expel"),    
            }))

      hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia msg volume-mute"))
        hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down"))
        hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up"))
        hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("noctalia msg mic-mute"))
        hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("noctalia msg brightness-down"))
        hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("noctalia msg brightness-up"))
        hl.bind("XF86Display", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
        hl.bind("XF86NotificationCenter", hl.dsp.exec_cmd("noctalia msg power-cycle"))
        hl.bind("XF86PickupPhone", hl.dsp.exec_cmd("noctalia msg bluetooth-toggle"))
        hl.bind("XF86HangupPhone", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
        hl.bind("XF86Favorites", hl.dsp.exec_cmd("noctalia msg settings-toggle")) 
        hl.bind("Print", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"))
        hl.bind("XF86SelectiveScreenshot", hl.dsp.exec_cmd("noctalia msg screenshot-region"))

        hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }))
        hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }))
        hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }))
        hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }))
        hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }))
        hl.bind("SUPER + 6", hl.dsp.focus({ workspace = "6" }))
        hl.bind("SUPER + 7", hl.dsp.focus({ workspace = "7" }))
        hl.bind("SUPER + 8", hl.dsp.focus({ workspace = "8" }))
        hl.bind("SUPER + 9", hl.dsp.focus({ workspace = "9" }))

        hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
        hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
        hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
        hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
        hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
        hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
        hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
        hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
        hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))

        hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
        hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
        hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
        hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

        hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
        hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
        hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
        hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
        '';
    };
  };
}
