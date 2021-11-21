{ pkgs, lib, ... }:

{
 xsession.windowManager.i3 = {
   enable = true;
   package = pkgs.i3-gaps;

   config = rec {
     modifier = "Mod1";
     bars = [ ];

     window.border = 0;
     
     gaps = {
       inner = 15;
       outer = 5;
     };

     keybindings = lib.mkOptionDefault {
       "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
       "${modifier}+d" = "exec --no-startup-id ${pkgs.dmenu}/bin/dmenu_run";
       "${modifier}+Shift+q" = "kill"; 
       "${modifier}+Shift+x" = "exec systemctl suspend";
       "${modifier}+Shift+c" = "reload";
       "${modifier}+Shift+r" = "restart";

       "${modifier}+h" = "focus left";
       "${modifier}+j" = "focus down";
       "${modifier}+k" = "focus up";
       "${modifier}+l" = "focus right";
       "${modifier}+Left" = "focus left";
       "${modifier}+Down" = "focus down";
       "${modifier}+Up" = "focus up";
       "${modifier}+Right" = "focus right";
       "${modifier}+Shift+h" = "move left"; 
       "${modifier}+Shift+j" = "move down"; 
       "${modifier}+Shift+k" = "move up"; 
       "${modifier}+Shift+l" = "move right"; 

 
       "${modifier}+b" = "split h";
       "${modifier}+v" = "split v";
       "${modifier}+f" = "fullscreen toggle";

       "${modifier}+s" = "layout stacking";
       "${modifier}+w" = "layout tabbed";
       "${modifier}+e" = "layout toggle split";

       "${modifier}+Shift+space" = "floating toggle";
       "${modifier}+space" = "focus mode_toggle";

       "${modifier}+a" = "focus parent";
       "${modifier}+z" = "focus child";

       "${modifier}+1" = "workspace number 1";
       "${modifier}+2" = "workspace number 2";
       "${modifier}+3" = "workspace number 3";
       "${modifier}+4" = "workspace number 4";
       "${modifier}+5" = "workspace number 5";
       "${modifier}+6" = "workspace number 6";
       "${modifier}+7" = "workspace number 7";
       "${modifier}+8" = "workspace number 8";
       "${modifier}+9" = "workspace number 9";
       "${modifier}+0" = "workspace number 10";

       "${modifier}+Shift+1" = "move container to workspace number 1";
       "${modifier}+Shift+2" = "move container to workspace number 2";
       "${modifier}+Shift+3" = "move container to workspace number 3";
       "${modifier}+Shift+4" = "move container to workspace number 4";
       "${modifier}+Shift+5" = "move container to workspace number 5";
       "${modifier}+Shift+6" = "move container to workspace number 6";
       "${modifier}+Shift+7" = "move container to workspace number 7";
       "${modifier}+Shift+8" = "move container to workspace number 8";
       "${modifier}+Shift+9" = "move container to workspace number 9";
       "${modifier}+Shift+0" = "move container to workspace number 10";

       "${modifier}+r" = "mode resize";
     };
  
     startup = [
       {
         command = "exec i3-msg workspace 1";
         always = true;
         notification = true;
       }
     ];
     
   };
 };
}
