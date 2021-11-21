{ pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-ruby
      vim-go
      vim-fish
      rust-vim
      vim-cute-python
      vim-lua
      vim-ocaml
      julia-vim
      idris2-vim
      vim-javascript
      typescript-vim
      gitignore-vim
      i3config-vim

      pears-nvim
      chadtree
      SudoEdit-vim

    ];
  };
}
