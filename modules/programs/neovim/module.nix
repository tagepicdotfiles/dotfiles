{username, inputs, ...}:
{config, pkgs, ...}: 
let 
    module_path = "${inputs.self}/modules/programs/neovim";
in
{
    home-manager.users.${username} = {
        home.sessionVariables = {
            EDITOR = "nvim";
        };
        programs.neovim = {
            enable = true;
            extraConfig = "so ${module_path}/config.vim";
            plugins = with pkgs.vimPlugins; [
                telescope-nvim
                nvim-lspconfig
                nvim-cmp
                cmp-nvim-lsp
                onedark-nvim
                lightline-vim
                fidget-nvim
                snippets-nvim
                vim-gitgutter
                dashboard-nvim
                vim-commentary
                nvim-surround
                emmet-vim
                nvim-treesitter.withAllGrammars
            ];
        };
    };

    users.users.${username}.packages = with pkgs; [
        nodePackages.typescript-language-server
        nodePackages.svelte-language-server
        nodePackages.pyright
        rust-analyzer
    ];
}
