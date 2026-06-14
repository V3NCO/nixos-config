{ config, ... }:
{
  home.file = {
    ".var/app/com.core447.StreamController/data/plugins/com_core447_OBSPlugin".source = ./plugins/com_core447_OBSPlugin;
    ".var/app/com.core447.StreamController/data/plugins/com_core447_OSPlugin".source = ./plugins/com_core447_OSPlugin;
    ".var/app/com.core447.StreamController/data/plugins/com_core447_QEMUPlugin".source = ./plugins/com_core447_QEMUPlugin;
    ".var/app/com.core447.StreamController/data/plugins/com_core447_Requests".source = ./plugins/com_core447_Requests;
    ".var/app/com.core447.StreamController/data/plugins/com_core447_Weather".source = ./plugins/com_core447_Weather;
    ".var/app/com.core447.StreamController/data/plugins/com_core447_DeckPlugin".source = ./plugins/com_core447_DeckPlugin;
    ".var/app/com.core447.StreamController/data/plugins/com_gapls_AudioControl".source = ./plugins/com_gapls_AudioControl;
    ".var/app/com.core447.StreamController/data/plugins/HomeAssistantPlugin".source = ./plugins/HomeAssistantPlugin;
    ".var/app/com.core447.StreamController/data/plugins/net_pniedzielski_OBSLiveSplitOnePlugin".source = ./plugins/net_pniedzielski_OBSLiveSplitOnePlugin;
  };
  # home.file.".var/app/com.core447.StreamController/data/Assets/AssetManager/Assets".source = ./Assets/assets;
  # home.file.".var/app/com.core447.StreamController/data/Assets/AssetManager/Thumbnails".source = ./Assets/thumbnails;
  # home.file.".var/app/com.core447.StreamController/data/Assets/AssetManager/Assets.json".text = builtins.toJSON ./Assets/assets.nix;
  programs.streamcontroller = {
    enable = true;

    dataPath = "${config.home.homeDirectory}/.var/app/com.core447.StreamController/data";

    defaultPages = {
      "AL46K2C70879" = "Default";
    };

    assets = {
      "arrow_back_24dp_E3E3E3.svg"= ./assets/arrow_back_24dp_E3E3E3.svg;
      "volume_down_24dp_E3E3E3.svg"= ./assets/volume_down_24dp_E3E3E3.svg;
      "volume_mute_24dp_E3E3E3.svg"= ./assets/volume_mute_24dp_E3E3E3.svg;
      "volume_up_24dp_E3E3E3.svg"= ./assets/volume_up_24dp_E3E3E3.svg;
      "play_pause_24dp_E3E3E3.svg"= ./assets/play_pause_24dp_E3E3E3.svg;
      "skip_next_24dp_E3E3E3.svg" = ./assets/skip_next_24dp_E3E3E3.svg;
      "skip_previous_24dp_E3E3E3.svg" = ./assets/skip_previous_24dp_E3E3E3.svg;
    };

    pages = {
      "Default" = {
        brightness = {
          value = 100;
        };
        screensaver = { };
        keys = {
          "0x0" = {
            states = {
              "0" = {
                media = {
                  path = "${config.programs.streamcontroller.dataPath}/assets/volume_up_24dp_E3E3E3.svg";
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::RunCommand";
                    "settings" = {
                      "command" = "wpctl set-volume @DEFAULT_SINK@ 5%+";
                    };
                  }
                ];
              };
            };
          };
          "0x1" = {
            states = {
              "0" = {
                media = {
                  path = "${config.programs.streamcontroller.dataPath}/assets/volume_down_24dp_E3E3E3.svg";
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::RunCommand";
                    "settings" = {
                      "command" = "wpctl set-volume @DEFAULT_SINK@ 5%-";
                    };
                  }
                ];
              };
            };
          };
          "0x2" = {
            states = {
              "0" = {
                media = {
                  path = "${config.programs.streamcontroller.dataPath}/assets/volume_mute_24dp_E3E3E3.svg";
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::RunCommand";
                    "settings" = {
                      "command" = "wpctl set-mute @DEFAULT_SINK@ toggle";
                    };
                  }
                ];
              };
            };
          };
          "1x1" = {
            states = {
              "0" = {
                media = {
                  path = "${config.programs.streamcontroller.dataPath}/assets/skip_previous_24dp_E3E3E3.svg";
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::RunCommand";
                    "settings" = {
                      "command" = "playerctl previous";
                    };
                  }
                ];
              };
            };
          };
          "2x1" = {
            states = {
              "0" = {
                media = {
                  path = "${config.programs.streamcontroller.dataPath}/assets/play_pause_24dp_E3E3E3.svg";
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::RunCommand";
                    "settings" = {
                      "command" = "playerctl play-pause";
                    };
                  }
                ];
              };
            };
          };
          "3x1" = {
            states = {
              "0" = {
                media = {
                  path = "${config.programs.streamcontroller.dataPath}/assets/skip_next_24dp_E3E3E3.svg";
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::RunCommand";
                    "settings" = {
                      "command" = "playerctl next";
                    };
                  }
                ];
              };
            };
          };
          "4x0" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F KEYS";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_DeckPlugin::ChangePage";
                    "settings" = {
                      "deck_number" = "AL46K2C70879";
                      "selected_page" = "/home/venco/.var/app/com.core447.StreamController/data/pages/F Keys.json";
                    };
                  }
                ];
              };
            };
          };
        };
      };

      "F Keys" = {
        brightness = {
          value = 90;
        };
        extraConfig = {
          "auto-change" = {
            "decks" = [
              "AL46K2C70879"
            ];
            "enable" = true;
            "stay_on_page" = true;
            "title" = "";
            "wm_class" = "";
          };
        };
        keys = {
          "0x0" = {
            states = {
              "0" = {
                media = {
                  path = "${config.programs.streamcontroller.dataPath}/assets/arrow_back_24dp_E3E3E3.svg";
                };
                actions = [
                  {
                    "id" = "com_core447_DeckPlugin::ChangePage";
                    "settings" = {
                      "deck_number" = "AL46K2C70879";
                      "selected_page" = "/home/venco/.var/app/com.core447.StreamController/data/pages/Default.json";
                    };
                  }
                ];
              };
            };
          };
          "0x1" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F5";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::Hotkey";
                    "settings" = {
                      "delay" = 0.09999999999999999;
                      "hold_until_release" = true;
                      "keys" = [
                        [
                          63
                          1
                        ]
                        [
                          63
                          0
                        ]
                      ];
                      "repeat" = false;
                    };
                  }
                ];
              };
            };
          };
          "0x2" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F10";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::Hotkey";
                    "settings" = {
                      "delay" = 0.09999999999999999;
                      "hold_until_release" = true;
                      "keys" = [
                        [
                          68
                          1
                        ]
                        [
                          68
                          0
                        ]
                      ];
                      "repeat" = false;
                    };
                  }
                ];
              };
            };
          };
          "1x0" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F1";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::Hotkey";
                    "settings" = {
                      "delay" = 0.09999999999999999;
                      "hold_until_release" = true;
                      "keys" = [
                        [
                          59
                          1
                        ]
                        [
                          59
                          0
                        ]
                      ];
                      "repeat" = false;
                    };
                  }
                ];
              };
            };
          };
          "1x1" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F6";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::Hotkey";
                    "settings" = {
                      "delay" = 0.09999999999999999;
                      "hold_until_release" = true;
                      "keys" = [
                        [
                          64
                          1
                        ]
                        [
                          64
                          0
                        ]
                      ];
                      "repeat" = false;
                    };
                  }
                ];
              };
            };
          };
          "1x2" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F11";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::Hotkey";
                    "settings" = {
                      "delay" = 0.09999999999999999;
                      "hold_until_release" = true;
                      "keys" = [
                        [
                          87
                          1
                        ]
                        [
                          87
                          0
                        ]
                      ];
                      "repeat" = false;
                    };
                  }
                ];
              };
            };
          };
          "2x0" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F2";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::Hotkey";
                    "settings" = {
                      "delay" = 0.09999999999999999;
                      "hold_until_release" = true;
                      "keys" = [
                        [
                          60
                          1
                        ]
                        [
                          60
                          0
                        ]
                      ];
                      "repeat" = false;
                    };
                  }
                ];
              };
            };
          };
          "2x1" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F7";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::Hotkey";
                    "settings" = {
                      "delay" = 0.09999999999999999;
                      "hold_until_release" = true;
                      "keys" = [
                        [
                          65
                          1
                        ]
                        [
                          65
                          0
                        ]
                      ];
                      "repeat" = false;
                    };
                  }
                ];
              };
            };
          };
          "2x2" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F12";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::Hotkey";
                    "settings" = {
                      "delay" = 0.09999999999999999;
                      "hold_until_release" = true;
                      "keys" = [
                        [
                          88
                          1
                        ]
                        [
                          88
                          0
                        ]
                      ];
                      "repeat" = false;
                    };
                  }
                ];
              };
            };
          };
          "3x0" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F3";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::Hotkey";
                    "settings" = {
                      "delay" = 0.09999999999999999;
                      "hold_until_release" = true;
                      "keys" = [
                        [
                          61
                          1
                        ]
                        [
                          61
                          0
                        ]
                      ];
                      "repeat" = false;
                    };
                  }
                ];
              };
            };
          };
          "3x1" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F8";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::Hotkey";
                    "settings" = {
                      "delay" = 0.09999999999999999;
                      "hold_until_release" = true;
                      "keys" = [
                        [
                          66
                          1
                        ]
                        [
                          66
                          0
                        ]
                      ];
                      "repeat" = false;
                    };
                  }
                ];
              };
            };
          };
          "4x0" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F4";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::Hotkey";
                    "settings" = {
                      "delay" = 0.09999999999999999;
                      "hold_until_release" = true;
                      "keys" = [
                        [
                          62
                          1
                        ]
                        [
                          62
                          0
                        ]
                      ];
                      "repeat" = false;
                    };
                  }
                ];
              };
            };
          };
          "4x1" = {
            states = {
              "0" = {
                label = {
                  center = {
                    text = "F9";
                  };
                };
                actions = [
                  {
                    "id" = "com_core447_OSPlugin::Hotkey";
                    "settings" = {
                      "delay" = 0.09999999999999999;
                      "hold_until_release" = true;
                      "keys" = [
                        [
                          67
                          1
                        ]
                        [
                          67
                          0
                        ]
                      ];
                      "repeat" = false;
                    };
                  }
                ];
              };
            };
          };
        };
      };
    };
  };
}
