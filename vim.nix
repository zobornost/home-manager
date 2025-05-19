{ pkgs, ... }:
{
  programs.neovim = {
    enable    = true;
    vimAlias = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; [
        dashboard-nvim
        nvim-web-devicons
        lualine-nvim
        telescope-nvim
        which-key-nvim
        vim-move
        project-nvim
        vim-repeat
    ];

    extraLuaConfig = builtins.readFile ./init.lua;
  };
}