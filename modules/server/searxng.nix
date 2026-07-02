{ config, lib, ... }:
{
  homelab = {
    ports = [ config.services.searx.settings.server.port ];
    services = {
      searxng = {
        subdomain = "search";
        zone = "v3nco";
        upstream = {
          scheme = "http";
          host = "127.0.0.1";
          port = config.services.searx.settings.server.port;
        };
      };
    };
  };

  services.searx = {
    enable = true;
    redisCreateLocally = true;
    environmentFile = "/var/lib/searx/.env";

    # Rate limiting
    limiterSettings = {
      real_ip = {
        x_for = 1;
        ipv4_prefix = 32;
        ipv6_prefix = 56;
      };

      botdetection = {
        trusted_proxies = [
          "127.0.0.1"
          "::1"
        ];

        ip_limit = {
          filter_link_local = true;
          link_token = false;
        };

        ip_lists = {
          pass_ip = [
            "127.0.0.1"
            "::1"
          ];
        };
      };
    };

    # Searx configuration
    settings = {
      # Instance settings
      general = {
        debug = false;
        instance_name = "Sentinel Search";
        donation_url = false;
        contact_url = false;
        privacypolicy_url = false;
        enable_metrics = false;
      };

      # User interface
      ui = {
        static_use_hash = true;
        default_locale = "en";
        query_in_title = true;
        infinite_scroll = false;
        center_alignment = true;
        default_theme = "simple";
        theme_args.simple_style = "auto";
        search_on_category_select = false;
        hotkeys = "vim";
      };

      # Search engine settings
      search = {
        safe_search = 2;
        autocomplete_min = 2;
        autocomplete = "duckduckgo";
        ban_time_on_fail = 5;
        max_ban_time_on_fail = 120;
        formats = [ "html" "json" ];
      };

      # Server configuration
      server = {
        base_url = "https://search.v3nco.dev";
        port = 23489;
        bind_address = "127.0.0.1";
        limiter = true;
        public_instance = false;
        image_proxy = true;
        method = "GET";
      };

      # Search engines
      engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
        "duckduckgo".disabled = false;
        "brave".disabled = true;
        "bing".disabled = true;
        "mojeek".disabled = true;
        "mwmbl".disabled = false;
        "mwmbl".weight = 0.4;
        "qwant".disabled = false;
        "crowdview".disabled = false;
        "crowdview".weight = 0.5;
        "curlie".disabled = true;
        "ddg definitions".disabled = false;
        "ddg definitions".weight = 2;
        "wikibooks".disabled = false;
        "wikidata".disabled = false;
        "wikiquote".disabled = false;
        "wikisource".disabled = false;
        "wikispecies".disabled = false;
        "wikispecies".weight = 0.5;
        "wikiversity".disabled = false;
        "wikiversity".weight = 0.5;
        "wikivoyage".disabled = false;
        "wikivoyage".weight = 0.5;
        "currency".disabled = false;
        "dictzone".disabled = true;
        "lingva".disabled = true;
        "bing images".disabled = false;
        "brave.images".disabled = true;
        "duckduckgo images".disabled = true;
        "google images".disabled = false;
        "qwant images".disabled = true;
        "1x".disabled = true;
        "artic".disabled = false;
        "deviantart".disabled = false;
        "flickr".disabled = true;
        "imgur".disabled = false;
        "library of congress".disabled = false;
        "material icons".disabled = false;
        "material icons".weight = 0.2;
        "openverse".disabled = false;
        "pinterest".disabled = false;
        "svgrepo".disabled = false;
        "unsplash".disabled = false;
        "wallhaven".disabled = false;
        "wikicommons.images".disabled = false;
        "yacy images".disabled = true;
        "bing videos".disabled = false;
        "brave.videos".disabled = true;
        "duckduckgo videos".disabled = true;
        "google videos".disabled = false;
        "qwant videos".disabled = false;
        "dailymotion".disabled = true;
        "google play movies".disabled = true;
        "invidious".disabled = false;
        "odysee".disabled = true;
        "peertube".disabled = false;
        "piped".disabled = true;
        "rumble".disabled = false;
        "sepiasearch".disabled = false;
        "vimeo".disabled = true;
        "youtube".disabled = false;
        "brave.news".disabled = true;
        "google news".disabled = false;
      };

      # Outgoing requests
      outgoing = {
        request_timeout = 5.0;
        max_request_timeout = 15.0;
        pool_connections = 100;
        pool_maxsize = 15;
        enable_http2 = true;
      };

      enabled_plugins = [
        "Basic Calculator"
        "Hash plugin"
        "Tor check plugin"
        "Open Access DOI rewrite"
        "Hostnames plugin"
        "Unit converter plugin"
        "Tracker URL remover"
      ];
    };
  };
}
