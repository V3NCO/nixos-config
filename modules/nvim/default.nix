{ pkgs, inputs, ... }:
{
  nixCats = {
    enable = true;
    packageNames = [ "nvim" ];

    luaPath = ./.; # Points to modules/nvim/ where init.lua lives

    categoryDefinitions.replace =
      {
        pkgs,
        settings,
        categories,
        extra,
        name,
        mkPlugin,
        ...
      }@packageDef:
      {
        lspsAndRuntimeDeps = {
          general = with pkgs; [
            lazygit
            lua-language-server
            stylua
            nixd
            alejandra
            gopls
          ];
        };

        # Use propagatedBuildInputs for plugins that need to be in lua path
        startupPlugins = {
          general = with pkgs.vimPlugins; [
            # UI & Core
            snacks-nvim
            onedark-nvim
            vim-sleuth
            mini-ai
            mini-icons
            mini-pairs

            # LSP
            nvim-lspconfig

            # Completion
            blink-cmp

            # Treesitter
            nvim-treesitter.withAllGrammars

            # Status line
            lualine-nvim
            lualine-lsp-progress

            # Git
            gitsigns-nvim

            # Keybindings
            which-key-nvim

            # Linting & Formatting
            nvim-lint
            conform-nvim

            # Debugging
            nvim-dap
            nvim-dap-ui
            nvim-dap-virtual-text
            nvim-nio # Required dependency for nvim-dap-ui

            # Startup time profiling
            vim-startuptime
            vim-wakatime

            nvim-tree-lua
            nvim-web-devicons
            trouble-nvim
          ];
        };

        optionalPlugins = {
          general = with pkgs.vimPlugins; [
            lazydev-nvim
          ];
        };
      };

    packageDefinitions.replace = {
      nvim =
        { pkgs, name, ... }:
        {
          settings = {
            suffix-path = true;
            suffix-LD = true;
            # Add wrapRc to ensure lua files are found
            wrapRc = true;
          };
          categories = {
            general = true;
          };
        };
    };
  };
}
