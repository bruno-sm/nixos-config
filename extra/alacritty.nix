{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        title = "Terminal";

        padding = { y = 5; };
      };

     # font = {
     #   normal.family = "JetbrainsMono Nerd Font";
     #   size = 8.0;
     # };

      background_opacity = 1.0;

      colors = {
        primary = {
          background = "0xfcfcff";
          foreground = "0x131432";
        };
        cursor = {
          text = "0xfcfcff";
          cursor = "0x131432";
        };
        normal = {
          black = "0x050405";
          red = "0xec8d8d";
          green = "0x8ed081";
          yellow = "0xf9e2b1";
          blue = "0x050405";
          magenta = "0x52304D";
          cyan = "0x3ae9fa";
          white = "0xfcfcff";
        };
        bright = {
          black = "0x050405";
          red = "0xec8d8d";
          green = "0x8ed081";
          yellow = "0xf9e2b1";
          blue = "0x050405";
          magenta = "0x52304D";
          cyan = "0x3ae9fa";
          white = "0xfcfcff";
        };
      };
    };
  };
}
