{ pkgs, inputs, ... }:
{
  nixCats = {
    enable = true;
    packageNames = [ "nvim" ];

    # Point to your lua config directory
    luaPath = "."; # or wherever your init.lua, plugin/, ftplugin/ are

    # Define your categories (plugins, LSPs, etc.)
    categoryDefinitions =
      { pkgs, ... }:
      {
        lspsAndRuntimeDeps = {
          general = with pkgs; [
            lua-language-server
            nixd
            stylua
          ];
        };
        startupPlugins = {
          general = with pkgs.vimPlugins; [
            nvim-lspconfig
            nvim-treesitter.withAllGrammars
            # ... your plugins
          ];
        };
      };

    # Define your package
    packageDefinitions = {
      nvim =
        { pkgs, ... }:
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
