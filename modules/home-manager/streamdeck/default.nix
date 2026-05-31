{ config, ... }:
{
  home.file.".var/app/com.core447.StreamController/data/plugins".source = ./plugins;
  # home.file.".var/app/com.core447.StreamController/data/Assets/AssetManager/Assets".source = ./Assets/assets;
  # home.file.".var/app/com.core447.StreamController/data/Assets/AssetManager/Thumbnails".source = ./Assets/thumbnails;
  # home.file.".var/app/com.core447.StreamController/data/Assets/AssetManager/Assets.json".text = builtins.toJSON ./Assets/assets.nix;
  programs.streamcontroller = {
    enable = true;

    defaultPages = {
      "AL46K2C70879" = "Default";
    };

    assets = {
      "arrow_back_24dp_E3E3E3.svg"= ./assets/arrow_back_24dp_E3E3E3.svg;
      "volume_down_24dp_E3E3E3.svg"= ./assets/volume_down_24dp_E3E3E3.svg;
      "volume_mute_24dp_E3E3E3.svg"= ./assets/volume_mute_24dp_E3E3E3.svg;
      "volume_up_24dp_E3E3E3.svg"= ./assets/volume_up_24dp_E3E3E3.svg;
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
                      "command" = "noctalia-shell ipc call volume increase";
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
                      "command" = "noctalia-shell ipc call volume decrease";
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
                      "command" = "noctalia-shell ipc call volume muteOutput";
                    };
                  }
                ];
              };
            };
          };
          "1x0" = {
            states = {
              "0" = {
                actions = [
                  {
                    "comment" = "Vol +";
                    "id" = "com_core447_OSPlugin::RunCommand";
                    "settings" = {
                      "command" = "noctalia-shell ipc call volume increase";
                    };
                  }
                ];
              };
            };
          };
          "1x1" = {
            states = {
              "0" = {
                actions = [
                  {
                    "id" = "com_core447_MediaPlugin::Previous";
                    "settings" = {
                      "show_label" = true;
                      "show_thumbnail" = true;
                    };
                  }
                ];
              };
            };
          };
          "2x1" = {
            states = {
              "0" = {
                actions = [
                  {
                    "id" = "com_core447_MediaPlugin::PlayPause";
                    "settings" = {
                      "show_label" = true;
                      "show_thumbnail" = true;
                    };
                  }
                ];
                label-control-actions = [
                  0
                  0
                  0
                ];
              };
            };
          };
          "3x1" = {
            states = {
              "0" = {
                actions = [
                  {
                    "id" = "com_core447_MediaPlugin::Next";
                    "settings" = {
                      "show_label" = true;
                      "show_thumbnail" = true;
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
