{pkgs, ...}: {
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    extraConfig = builtins.readFile ./vimrc;
    plugins = with pkgs.vimPlugins; [
      asyncomplete-lsp-vim
      asyncomplete-vim
      nerdtree
      vim-lsp
      vim-lsp-settings
      vim-vsnip
      vim-vsnip-integ
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
