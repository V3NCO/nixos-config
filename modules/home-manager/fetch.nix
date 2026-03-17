{ config, ... }:
{

  home.file."${config.xdg.configHome}/nixosassets/ascii" = {
    source = ./ascii;
    recursive = true;
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        type = "auto";
        source = "${config.xdg.configHome}/nixosassets/ascii/fastfetch.txt";
        color = {
          "1" = "#9683EC";
          "2" = "#D6CDFE";
          "3" = "#FFFFFF";
        };
      };
      display = {
        color = {
          keys = "blue";
        };
        separator = "";
        constants = [
          "──────────────────────────────────────────────"
          "[47D"
          "[47C"
          "[46C"
          "══════════════════════════════════════════════"
        ];
        brightColor = true;
      };
      modules = [
        {
          type = "version";
          key = "╔═══════════════╦═{$5}╗[41D";
          format = "[1m{#keys} {1} - {2} ";
        }
        {
          type = "os";
          key = "║  {icon}  [s{sysname}[u[10C║{$3}║{$2}";
        }
        {
          type = "datetime";
          key = "║  {icon}  Fetched   ║{$3}║{$2}";
          format = "{year}-{month-pretty}-{day-pretty} {hour-pretty}:{minute-pretty}:{second-pretty} {timezone-name}";
        }
        {
          type = "locale";
          key = "║  {icon}  Locale    ║{$3}║{$2}";
        }
        {
          type = "custom";
          key = "║{#cyan}┌──────────────┬{$1}┐{#keys}║[37D";
          format = "{#bright_cyan} Hardware ";
        }
        {
          type = "chassis";
          key = "║{#cyan}│ {icon}  Chassis   │{$4}│{#keys}║{$2}";
        }
        {
          type = "memory";
          key = "║{#cyan}│ {icon}  RAM       │{$4}│{#keys}║{$2}";
        }
        {
          type = "swap";
          key = "║{#cyan}│ {icon}  SWAP      │{$4}│{#keys}║{$2}";
        }
        {
          type = "cpu";
          key = "║{#cyan}│ {icon}  CPU       │{$4}│{#keys}║{$2}";
          showPeCoreCount = true;
        }
        {
          type = "gpu";
          key = "║{#cyan}│ {icon}  GPU       │{$4}│{#keys}║{$2}";
        }
        {
          type = "disk";
          key = "║{#cyan}│ {icon}  Disk      │{$4}│{#keys}║{$2}";
          format = "{size-used} / {size-total} ({size-percentage}) - {filesystem}";
        }
        {
          type = "battery";
          key = "║{#cyan}│ {icon}  Battery   │{$4}│{#keys}║{$2}";
        }
        {
          type = "custom";
          key = "║{#cyan}└──────────────┴{$1}┘{#keys}║";
          format = "";
        }
        {
          type = "custom";
          key = "║{#green}┌──────────────┬{$1}┐{#keys}║[37D";
          format = "{#bright_green} Desktop ";
        }
        {
          type = "de";
          key = "║{#green}│ {icon}  Desktop   │{$4}│{#keys}║{$2}";
        }
        {
          type = "wm";
          key = "║{#green}│ {icon}  Session   │{$4}│{#keys}║{$2}";
        }
        {
          type = "display";
          key = "║{#green}│ {icon}  Display   │{$4}│{#keys}║{$2}";
          compactType = "original-with-refresh-rate";
        }
        {
          type = "gpu";
          key = "║{#green}│ {icon}  G-Driver  │{$4}│{#keys}║{$2}";
          format = "{driver}";
        }
        {
          type = "custom";
          key = "║{#green}└──────────────┴{$1}┘{#keys}║";
          format = "";
        }
        {
          type = "custom";
          key = "║{#yellow}┌──────────────┬{$1}┐{#keys}║[37D";
          format = "{#bright_yellow} Terminal ";
        }
        {
          type = "shell";
          key = "║{#yellow}│ {icon}  Shell     │{$4}│{#keys}║{$2}";
        }
        {
          type = "terminal";
          key = "║{#yellow}│ {icon}  Terminal  │{$4}│{#keys}║{$2}";
        }
        {
          type = "terminalfont";
          key = "║{#yellow}│ {icon}  Term Font │{$4}│{#keys}║{$2}";
        }
        {
          type = "terminaltheme";
          key = "║{#yellow}│ {icon}  Colors    │{$4}│{#keys}║{$2}";
        }
        {
          type = "packages";
          key = "║{#yellow}│ {icon}  Packages  │{$4}│{#keys}║{$2}";
        }
        {
          type = "custom";
          key = "║{#yellow}└──────────────┴{$1}┘{#keys}║";
          format = "";
        }
        {
          type = "custom";
          key = "║{#red}┌──────────────┬{$1}┐{#keys}║[39D";
          format = "{#bright_red} Development ";
        }
        {
          type = "command";
          keyIcon = "";
          key = "║{#red}│ {icon}  Rust      │{$4}│{#keys}║{$2}";
          text = "rustc --version";
          format = "rustc {~6,13}";
        }
        {
          type = "command";
          condition = {
            "!system" = "Windows";
          };
          keyIcon = "";
          key = "║{#red}│ {icon}  Clang     │{$4}│{#keys}║{$2}";
          text = "clang --version | sed -n 's/.*version \\([0-9][0-9.]*\\).*/\\1/p'";
          format = "clang {}";
        }
        {
          type = "command";
          condition = {
            system = "Windows";
          };
          keyIcon = "";
          key = "║{#red}│ {icon}  Clang     │{$4}│{#keys}║{$2}";
          text = "clang --version | findstr version";
          format = "clang {~-6}";
        }
        {
          type = "command";
          keyIcon = "";
          key = "║{#red}│ {icon}  NodeJS    │{$4}│{#keys}║{$2}";
          text = "node --version";
          format = "node {~1}";
        }
        {
          type = "command";
          keyIcon = "";
          key = "║{#red}│ {icon}  Go        │{$4}│{#keys}║{$2}";
          text = "go version | cut -d' ' -f3";
          format = "go {~2}";
        }
        {
          type = "command";
          keyIcon = "";
          key = "║{#red}│ {icon}  Zig       │{$4}│{#keys}║{$2}";
          text = "zig version";
          format = "zig {}";
        }
        {
          type = "editor";
          key = "║{#red}│ {icon}  Editor    │{$4}│{#keys}║{$2}";
        }
        {
          type = "command";
          keyIcon = "󰊢";
          key = "║{#red}│ {icon}  Git       │{$4}│{#keys}║{$2}";
          text = "git version";
          format = "git {~12}";
        }
        {
          type = "font";
          key = "║{#red}│ {icon}  Interface │{$4}│{#keys}║{$2}";
        }
        {
          type = "custom";
          key = "║{#red}└──────────────┴{$1}┘{#keys}║";
          format = "";
        }
        {
          type = "custom";
          key = "║{#magenta}┌──────────────┬{$1}┐{#keys}║[36D";
          format = "{#bright_magenta} Uptime ";
        }
        {
          type = "uptime";
          key = "║{#magenta}│ {icon}  Uptime    │{$4}│{#keys}║{$2}";
        }
        {
          type = "users";
          myselfOnly = true;
          keyIcon = "";
          key = "║{#magenta}│ {icon}  Login     │{$4}│{#keys}║{$2}";
        }
        {
          condition = {
            "!system" = "macOS";
          };
          type = "disk";
          keyIcon = "";
          key = "║{#magenta}│ {icon}  OS Age    │{$4}│{#keys}║{$2}";
          folders = "/";
          format = "{create-time:10} [{days} days]";
        }
        {
          condition = {
            system = "macOS";
          };
          type = "disk";
          keyIcon = "";
          key = "║{#magenta}│ {icon}  OS Age    │{$4}│{#keys}║{$2}";
          folders = "/System/Volumes/VM";
          format = "{create-time:10} [{days} days]";
        }
        {
          type = "custom";
          key = "║{#magenta}└──────────────┴{$1}┘{#keys}║";
          format = "";
        }
        {
          type = "custom";
          key = "╚═════════════════{$5}╝";
          format = "";
        }
        "break"
        "colors"
      ];
    };
  };

  programs.hyfetch = {
    enable = true;
    settings = {
          "preset" = "omnisexual";
          "mode" = "rgb";
          "auto_detect_light_dark" = true;
          "light_dark" = "dark";
          "lightness" = 0.64;
          "color_align"= {
              "mode"= "custom";
              "custom_colors"= {
                "1" = 0;
                "2" = 1;
                "3" = 4;
              };
          };
          "backend"= "fastfetch";
          "pride_month_disable" = false;
          "custom_ascii_path" = "${config.xdg.configHome}/nixosassets/ascii/hyfetch.txt";
    };
  };
}
