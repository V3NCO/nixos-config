{ config, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.file."${config.xdg.configHome}/nixosassets/noctalia" = {
    source = ./assets;
    recursive = true;
  };

  programs.noctalia = {
    enable = true;

    settings = {
      accessibility = {
        high_contrast = false;
        ui_scale = 1.0;
      };

      audio = {
        enable_overdrive = true;
        enable_sounds = true;
        notification_sound = "";
        sound_volume = 0.5;
        volume_change_sound = "";
      };

      backdrop = {
        blur_intensity = 0.5;
        enabled = false;
        tint_intensity = 0.3;
      };

      bar = {
        order = [ "widgets" ];
        widgets = {
          auto_hide = false;
          background_opacity = 0.75;
          border = "outline";
          border_width = 0.0;
          capsule = false;
          capsule_fill = "surface_variant";
          capsule_opacity = 1.0;
          capsule_padding = 6.0;
          capsule_thickness = 0.76;
          center = [ "clock" "audio_visualizer" ];
          concave_edge_corners = true;
          contact_shadow = true;
          enabled = true;
          end = [ "tray" "media" "battery" "notifications" "session" ];
          font_weight = 500;
          hover_highlight = true;
          layer = "top";
          margin_edge = 6;
          margin_ends = 40;
          margin_opposite_edge = 0;
          padding = 14;
          panel_overlap = 1;
          position = "top";
          radius = 80;
          radius_bottom_left = 80;
          radius_bottom_right = 80;
          radius_top_left = 80;
          radius_top_right = 80;
          reserve_space = true;
          scale = 1.0;
          shadow = true;
          show_on_workspace_switch = true;
          smart_auto_hide = false;
          start = [ "control-center" "recorder" "group:g1" "group:g2" ];
          thickness = 34;
          widget_spacing = 6;

          capsule_group = [
            {
              accordion = false;
              accordion_direction = "end";
              enabled = true;
              fill = "surface_variant";
              id = "g1";
              members = [
                "network"
                "bluetooth"
              ];
              opacity = 1.0;
              padding = 6.0;
            }
            {
              accordion = false;
              accordion_direction = "end";
              enabled = true;
              fill = "surface_variant";
              id = "g2";
              members = [
                "workspaces"
                "active_window"
              ];
              opacity = 0.699999988079071;
              padding = 10.0;
            }
          ];
        };
      };

      battery = {
        warning_threshold = 10;
      };

      brightness = {
        enable_ddcutil = false;
        ignore_mmids = [ ];
        minimum_brightness = 0.0;
        sync_all_monitors = false;
      };

      calendar = {
        enabled = true;
        refresh_minutes = 15;
      };

      control_center = {
        hidden_tabs = [ ];
        show_shortcut_labels = true;
        sidebar = "compact";
        sidebar_section = "compact";
        width = 700;

        calendar = {
          event_date_format = "%A %e %B";
          event_time_format = "%H:%M";
          show_events_card = true;
          show_week_numbers = false;
        };

        shortcuts = [
          { type = "notification"; }
          { type = "caffeine"; }
          { type = "wifi"; }
          { type = "bluetooth"; }
          { type = "dark_mode"; }
          { type = "wallpaper"; }
        ];
      };

      desktop_widgets = {
        enabled = true;
        schema_version = 2;
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
      };

      dock = {
        active_monitor_only = false;
        active_opacity = 1.0;
        active_scale = 1.0;
        auto_hide = false;
        background_opacity = 0.88;
        border = "outline";
        border_width = 0.0;
        concave_edge_corners = true;
        cross_axis_padding = 8;
        enabled = false;
        icon_size = 48;
        inactive_opacity = 0.85;
        inactive_scale = 0.85;
        item_spacing = 6;
        launcher_custom_image = "";
        launcher_custom_image_colorize = false;
        launcher_icon = "grid-dots";
        launcher_position = "none";
        layer = "top";
        magnification = true;
        magnification_scale = 1.45;
        main_axis_padding = 16;
        margin_edge = 0;
        margin_ends = 0;
        monitors = [ ];
        pinned = [ ];
        position = "bottom";
        radius = 16;
        radius_bottom_left = 16;
        radius_bottom_right = 16;
        radius_top_left = 16;
        radius_top_right = 16;
        reserve_space = true;
        shadow = true;
        show_dots = false;
        show_instance_count = true;
        show_running = true;
        smart_auto_hide = false;
      };

      hooks = {
        battery_charging = [ ];
        battery_discharging = [ ];
        battery_percentage_changed = [ ];
        battery_plugged = [ ];
        bluetooth_disabled = [ ];
        bluetooth_enabled = [ ];
        colors_changed = [ ];
        logging_out = [ ];
        power_profile_changed = [ ];
        rebooting = [ ];
        session_locked = [ ];
        session_unlocked = [ ];
        shutting_down = [ ];
        started = [ ];
        theme_mode_changed = [ ];
        wallpaper_changed = [ ];
        wifi_disabled = [ ];
        wifi_enabled = [ ];
      };

      hot_corners = {
        delay_ms = 0;
        enabled = false;
        bottom_left = { action = "none"; command = ""; };
        bottom_right = { action = "none"; command = ""; };
        top_left = { action = "none"; command = ""; };
        top_right = { action = "none"; command = ""; };
      };

      idle = {
        behavior_order = [ "lock" "screen-off" "lock-and-suspend" ];
        pre_action_fade_seconds = 2.0;

        behavior = {
          lock = {
            action = "lock";
            command = "";
            enabled = true;
            resume_command = "";
            timeout = 600.0;
          };
          lock-and-suspend = {
            action = "lock_and_suspend";
            command = "";
            enabled = true;
            resume_command = "";
            timeout = 900.0;
          };
          screen-off = {
            action = "screen_off";
            command = "";
            enabled = true;
            resume_command = "";
            timeout = 660.0;
          };
        };
      };

      keybinds = {
        cancel = [ "Escape" ];
        copy = [ "Ctrl+c" ];
        delete = [ "Delete" ];
        down = [ "Down" ];
        left = [ "Left" ];
        right = [ "Right" ];
        save = [ "Ctrl+s" ];
        tab_next = [ "Tab" ];
        tab_previous = [ "Shift+ISO_Left_Tab" ];
        up = [ "Up" ];
        validate = [ "Return" "KP_Enter" "space" ];
      };

      location = {
        address = "";
        auto_locate = true;
        custom_schedule = false;
        sunrise = "";
        sunset = "";
      };

      lockscreen = {
        allow_empty_password = false;
        blur_intensity = 0.8;
        blurred_desktop = false;
        enabled = true;
        fingerprint = true;
        lock_before_suspend = true;
        monitors = [ ];
        tint_intensity = 0.3;
        wallpaper = "";
      };

      lockscreen_widgets = {
        enabled = true;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@eDP-1"
          "lockscreen-login-box@HDMI-A-2"
          "lockscreen-login-box@DP-2"
          "lockscreen-login-box@DP-1"
          "lockscreen-widget-0000000000000001"
          "lockscreen-widget-0000000000000002"
          "lockscreen-widget-0000000000000003"
          "lockscreen-widget-0000000000000006"
          "lockscreen-widget-0000000000000007"
        ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        widget = {
          "lockscreen-login-box@DP-1" = {
            box_height = 196.0;
            box_width = 810.0;
            cx = 960.0;
            cy = 957.0;
            enabled = true;
            output = "DP-1";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
          };
          "lockscreen-login-box@DP-2" = {
            box_height = 196.0;
            box_width = 810.0;
            cx = 960.0;
            cy = 957.0;
            enabled = true;
            output = "DP-2";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
          };
          "lockscreen-login-box@HDMI-A-2" = {
            box_height = 196.0;
            box_width = 810.0;
            cx = 960.0;
            cy = 979.0;
            enabled = true;
            output = "HDMI-A-2";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
          };
          "lockscreen-login-box@eDP-1" = {
            box_height = 196.0;
            box_width = 810.0;
            cx = 960.0;
            cy = 1018.0;
            enabled = true;
            output = "eDP-1";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
          };
          lockscreen-widget-0000000000000001 = {
            box_height = 192.0;
            box_width = 512.0;
            cx = 960.0;
            cy = 540.0;
            enabled = true;
            output = "HDMI-A-2";
            rotation = 0.0;
            type = "clock";
            settings = {
              background = true;
              clock_style = "digital";
              font_family = "Google Sans Flex";
              format = "{:%H:%M:%S}";
              shadow = true;
            };
          };
          lockscreen-widget-0000000000000002 = {
            box_height = 144.0;
            box_width = 320.0;
            cx = 860.0;
            cy = 724.0;
            enabled = true;
            output = "HDMI-A-2";
            rotation = 0.0;
            type = "media_player";
            settings = { };
          };
          lockscreen-widget-0000000000000003 = {
            box_height = 176.0;
            box_width = 240.0;
            cx = 824.0;
            cy = 348.0;
            enabled = true;
            output = "HDMI-A-2";
            rotation = 0.0;
            type = "sysmon";
            settings = { };
          };
          lockscreen-widget-0000000000000006 = {
            box_height = 144.0;
            box_width = 176.0;
            cx = 1128.0;
            cy = 724.0;
            enabled = true;
            output = "HDMI-A-2";
            rotation = 0.0;
            type = "weather";
            settings = { };
          };
          lockscreen-widget-0000000000000007 = {
            box_height = 176.0;
            box_width = 240.0;
            cx = 1096.0;
            cy = 348.0;
            enabled = true;
            output = "HDMI-A-2";
            rotation = 0.0;
            type = "sysmon";
            settings = {
              stat = "ram_pct";
            };
          };
        };
      };

      nightlight = {
        enabled = false;
        force = false;
        temperature_day = 6500;
        temperature_night = 4000;
      };

      notification = {
        background_opacity = 0.97;
        border = true;
        collapse_on_dismiss = true;
        enable_daemon = true;
        history_retention_hours = 0;
        layer = "top";
        max_visible = 0;
        monitors = [ ];
        offset_x = 20;
        offset_y = 8;
        position = "top_right";
        scale = 1.0;
        show_actions = true;
        show_app_name = true;
      };

      osd = {
        background_opacity = 0.97;
        border = true;
        enabled = true;
        monitors = [ ];
        offset_x = 20;
        offset_y = 8;
        orientation = "horizontal";
        position = "top_center";
        position_vertical = "top_center";
        scale = 1.0;
        kinds = {
          bluetooth = true;
          brightness = true;
          caffeine = true;
          dnd = true;
          keyboard_backlight = true;
          keyboard_layout = true;
          lock_keys = true;
          media = true;
          nightlight = true;
          power_profile = true;
          privacy = true;
          volume = true;
          volume_input = true;
          volume_output = true;
          wifi = true;
        };
      };

      plugins = {
        auto_update = true;
        enabled = [ "noctalia/screen_recorder" ];
        source = [
          {
            enabled = true;
            kind = "git";
            location = "https://github.com/noctalia-dev/official-plugins";
            name = "official";
          }
          {
            enabled = true;
            kind = "git";
            location = "https://github.com/noctalia-dev/community-plugins";
            name = "community";
          }
        ];
      };

      shell = {
        app_icon_color = "primary";
        app_icon_colorize = true;
        avatar_path = "${config.xdg.configHome}/nixosassets/pfp/venco.png";
        button_borders = true;
        card_borders = true;
        clipboard_auto_paste = "auto";
        clipboard_confirm_clear_history = true;
        clipboard_enabled = true;
        clipboard_history_max_entries = 100;
        clipboard_image_action_command = "";
        clipboard_keep_from_closed_apps = true;
        corner_radius_scale = 1.5;
        date_format = "%A, %x";
        disable_mipmaps = false;
        external_ip_enabled = false;
        font_family = "Google Sans Flex";
        input_borders = true;
        launch_apps_as_systemd_services = false;
        launch_apps_custom_command = "";
        niri_overview_type_to_launch_enabled = true;
        offline_mode = false;
        password_style = "random";
        polkit_agent = true;
        popup_borders = true;
        popup_shadows = true;
        screen_time_enabled = true;
        settings_show_advanced = true;
        settings_window_translucent = false;
        setup_wizard_enabled = true;
        shared_gl_context = true;
        show_location = true;
        telemetry_enabled = false;
        time_format = "{:%H:%M}";

        animation = {
          enabled = true;
          speed = 1.0;
        };

        greeter_sync = {
          auto_sync = false;
        };

        launcher = {
          app_grid = false;
          auto_paste = "auto";
          categories = true;
          compact = false;
          fetch_exchange_rates = true;
          provider_prefix = "/";
          show_icons = true;
          sort_by_usage = true;
        };

        mpris = {
          blacklist = [ ];
        };

        panel = {
          borders = true;
          clipboard_placement = "floating";
          clipboard_position = "center";
          control_center_placement = "floating";
          control_center_position = "auto";
          floating_layer = "overlay";
          floating_offset = 8;
          launcher_placement = "floating";
          launcher_position = "center";
          list_item_background = false;
          open_near_click_clipboard = true;
          open_near_click_control_center = true;
          open_near_click_launcher = false;
          open_near_click_session = false;
          open_near_click_wallpaper = false;
          polkit_placement = "floating";
          polkit_position = "center";
          session_placement = "attached";
          session_position = "auto";
          shadow = true;
          transparency_mode = "glass";
          wallpaper_placement = "attached";
          wallpaper_position = "auto";
        };

        privacy = {
          cam_filter_regex = "";
          mic_filter_regex = "";
          screen_filter_regex = "";
        };

        screen_corners = {
          enabled = true;
          size = 32;
        };

        screenshot = {
          confirm_region = false;
          copy_to_clipboard = true;
          directory = "";
          filename_pattern = "";
          freeze_screen = true;
          pipe_command = "";
          pipe_to_command = false;
          remember_last_region = false;
          save_to_file = true;
          show_cursor = false;
        };

        session = {
          grid = false;
          grid_columns = 3;
          show_shortcuts = true;
          actions = [
            {
              action = "lock";
              command = "";
              countdown_seconds = 0.0;
              enabled = true;
              glyph = "";
              label = "";
              shortcut = "1";
              variant = "default";
            }
            {
              action = "logout";
              command = "";
              countdown_seconds = 0.0;
              enabled = true;
              glyph = "";
              label = "";
              shortcut = "2";
              variant = "default";
            }
            {
              action = "lock_and_suspend";
              command = "";
              countdown_seconds = 0.0;
              enabled = true;
              glyph = "";
              label = "";
              shortcut = "3";
              variant = "default";
            }
            {
              action = "reboot";
              command = "";
              countdown_seconds = 0.0;
              enabled = true;
              glyph = "";
              label = "";
              shortcut = "4";
              variant = "default";
            }
            {
              action = "shutdown";
              command = "";
              countdown_seconds = 0.0;
              enabled = true;
              glyph = "";
              label = "";
              shortcut = "5";
              variant = "destructive";
            }
          ];
        };

        shadow = {
          alpha = 0.55;
          direction = "down_right";
        };
      };

      storage = {
        key_file = "";
        key_source = "secret-service";
      };

      system = {
        monitor = {
          cpu_poll_seconds = 2.0;
          cpu_temp_activity_threshold = 60.0;
          cpu_temp_critical_threshold = 85.0;
          cpu_temp_sensor_path = "";
          cpu_usage_activity_threshold = 50.0;
          cpu_usage_critical_threshold = 90.0;
          disk_free_activity_threshold = 80.0;
          disk_free_critical_threshold = 95.0;
          disk_free_pct_activity_threshold = 80.0;
          disk_free_pct_critical_threshold = 95.0;
          disk_poll_seconds = 10.0;
          disk_used_activity_threshold = 80.0;
          disk_used_critical_threshold = 95.0;
          disk_used_pct_activity_threshold = 80.0;
          disk_used_pct_critical_threshold = 95.0;
          enabled = true;
          gpu_poll_seconds = 5.0;
          gpu_temp_activity_threshold = 60.0;
          gpu_temp_critical_threshold = 85.0;
          gpu_usage_activity_threshold = 50.0;
          gpu_usage_critical_threshold = 95.0;
          gpu_vram_activity_threshold = 50.0;
          gpu_vram_critical_threshold = 90.0;
          memory_poll_seconds = 2.0;
          net_rx_activity_threshold = 1.0;
          net_rx_critical_threshold = 50.0;
          net_tx_activity_threshold = 1.0;
          net_tx_critical_threshold = 50.0;
          network_poll_seconds = 3.0;
          ram_pct_activity_threshold = 60.0;
          ram_pct_critical_threshold = 90.0;
          swap_pct_activity_threshold = 20.0;
          swap_pct_critical_threshold = 80.0;
        };
      };

      theme = {
        builtin = "Tokyo-Night";
        community_palette = "Oxocarbon";
        custom_palette = "";
        mode = "dark";
        pure_black_dark = false;
        source = "wallpaper";
        wallpaper_scheme = "m3-content";

        templates = {
          builtin_ids = [ "gtk3" "gtk4" "kcolorscheme" "qt" ];
          community_ids = [ ];
          enable_builtin_templates = true;
          enable_community_templates = true;
        };
      };

      wallpaper = {
        directory = "/home/venco/Pictures/Wallpapers";
        directory_dark = "/home/venco/Pictures/Wallpapers";
        directory_light = "/home/venco/Pictures/Wallpapers";
        edge_smoothness = 0.3;
        enabled = true;
        fill_color = "";
        fill_mode = "crop";
        per_monitor_directories = false;
        transition = [ "fade" "wipe" "disc" "stripes" "zoom" "honeycomb" ];
        transition_duration = 1500.0;
        transition_on_startup = true;

        automation = {
          enabled = false;
          interval_seconds = 1800;
          order = "random";
          recursive = true;
        };
      };

      weather = {
        effects = true;
        enabled = true;
        refresh_minutes = 30;
        unit = "metric";
      };

      widget = {
        active_window = {
          icon_size = 14.0;
          max_length = 260.0;
          min_length = 80.0;
          title_scroll = "none";
          type = "active_window";
        };
        control-center = {
          capsule_padding = 0.0;
          color = "primary";
          custom_image_colorize = true;
          font_weight = 380;
          glyph = "box-multiple-filled";
          type = "control-center";
        };
        cpu = {
          stat = "cpu_usage";
          type = "sysmon";
        };
        date = {
          format = "{:%a %d %b}";
          type = "clock";
        };
        input_volume = {
          device = "input";
          type = "volume";
        };
        keyboard_layout = {
          hide_when_single_layout = false;
          type = "keyboard_layout";
        };
        lock_keys = {
          display = "short";
          hide_when_off = false;
          show_caps_lock = true;
          show_num_lock = true;
          show_scroll_lock = false;
          type = "lock_keys";
        };
        media = {
          art_size = 16.0;
          capsule = true;
          hide_when_no_media = true;
          max_length = 220.0;
          min_length = 80.0;
          title_scroll = "always";
          type = "media";
        };
        network = {
          capsule = true;
          show_label = false;
          type = "network";
        };
        network_rx = {
          stat = "net_rx";
          type = "sysmon";
        };
        network_tx = {
          stat = "net_tx";
          type = "sysmon";
        };
        output_volume = {
          device = "output";
          type = "volume";
        };
        ram = {
          stat = "ram_used";
          type = "sysmon";
        };
        recorder = {
          type = "noctalia/screen_recorder:recorder";
        };
        spacer = {
          interactive = false;
          type = "spacer";
        };
        temp = {
          stat = "cpu_temp";
          type = "sysmon";
        };
        tray = {
          drawer = true;
          type = "tray";
        };
        workspaces = {
          capsule = true;
          labels_only_when_occupied = true;
          max_label_chars = 3;
          type = "workspaces";
        };
      };
    };
  };
}
