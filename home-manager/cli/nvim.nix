{ inputs', ... }:
{
  home.packages = [
    (inputs'.neovim-custom.packages.default.override {
      viAlias = true;
      vimAlias = true;
    })
  ];
}
