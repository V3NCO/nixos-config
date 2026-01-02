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
          ];
        };

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

            # Startup time profiling
            vim-startuptime
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
          };
          categories = {
            general = true;
          };
        };
    };
  };
}
