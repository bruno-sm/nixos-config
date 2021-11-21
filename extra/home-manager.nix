{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.bruno = {
    home.packages = with pkgs; [
      #cli
      fishPlugins.done

      #Utils
      zip
      unzip
      neofetch

      # Web
      brave

      # Media
      feh
      vlc

      # Dev
      alacritty
      fish
      docker
      clang_12
      python39
      julia-stable
      rustc
      cargo
    ];

    imports = [./i3.nix
               ./nvim.nix
	       ./alacritty.nix];
    home.keyboard.layout = "es";

    programs = {
      home-manager.enable = true;
      alacritty.enable = true;
      vim.enable = true;
      brave.enable = true;
    };

    programs.fish = {
      enable = true;

      functions = {
        fish_prompt = {
	  body = ''
	    set -l last_status $status

            # Just calculate these once, to save a few cycles when displaying the prompt
            if not set -q __fish_prompt_hostname
              set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
            end
            if not set -q __fish_prompt_char
              switch (id -u)
              case 0
                set -g __fish_prompt_char '#'
              case '*'
                set -g __fish_prompt_char 'λ'
              end
            end

            set -l normal (set_color normal)
            set -l white (set_color white)
            set -l cyan (set_color cyan)
            set -l yellow (set_color yellow)
            set -l red (set_color red)
            set -l blue (set_color blue)
            set -l green (set_color green)
            set -l purple (set_color purple)

            # Configure __fish_git_prompt
            set -g __fish_git_prompt_char_stateseparator ' '
            set -g __fish_git_prompt_color 5fdfff
            set -g __fish_git_prompt_color_flags df5f00
            set -g __fish_git_prompt_color_prefix purple
            set -g __fish_git_prompt_color_suffix purple
            set -g __fish_git_prompt_showdirtystate true
            set -g __fish_git_prompt_showuntrackedfiles true
            set -g __fish_git_prompt_showstashstate true
            set -g __fish_git_prompt_show_informative_status true

            set -l current_user (whoami)

            # Line 1
            echo -n $purple'╭─'$cyan$current_user$purple' at '$blue$__fish_prompt_hostname$purple' in '$red(pwd|sed "s=$HOME=⌁=")$blue
  __fish_git_prompt " (%s)"
            echo

            # Line 2
            echo -n $purple'╰'
            # support for virtual env name
            if set -q VIRTUAL_ENV
              echo -n "($cyan"(basename "$VIRTUAL_ENV")"$purple)"
            end
            echo -n $purple'─'$__fish_prompt_char $normal
	  '';
	};

	fish_right_prompt = ''
	  set -l exit_code $status
          set -l cmd_duration $CMD_DURATION
          __tmux_prompt
          if test $exit_code -ne 0
            set_color red
          else
            set_color green
          end
          printf '%d' $exit_code
          if test $cmd_duration -ge 5000
            set_color brcyan
          else
            set_color blue
          end
          printf ' (%s)' (__print_duration $cmd_duration)
          set_color 666666
          printf ' < %s' (date +%H:%M:%S)
          set_color normal
	'';

	__tmux_prompt = ''
	  set multiplexer (_is_multiplexed)

          switch $multiplexer
            case screen
              set pane (_get_screen_window)
            case tmux
              set pane (_get_tmux_window)
           end

          set_color 666666
          if test -z $pane
            echo -n ""
          else
            echo -n $pane' | '
          end
	'';

	__get_tmux_window = ''mux lsw | grep active | sed 's/\*.*$//g;s/: / /1' | awk '{ print $2 "-" $1 }' -''; 

	_get_screen_window = ''
	   set initial (screen -Q windows; screen -Q echo "")
           set middle (echo $initial | sed 's/  /\n/g' | grep '\*' | sed 's/\*\$ / /g')
           echo $middle | awk '{ print $2 "-" $1 }' -
	'';

	_is_multiplexed = ''
          set multiplexer ""
          if test -z $TMUX
          else
            set multiplexer "tmux"
          end
          if test -z $WINDOW
          else
            set multiplexer "screen"
          end
          echo $multiplexer
	'';

	__print_duration = ''
	  set -l duration $argv[1]
 
          set -l millis  (math $duration % 1000)
          set -l seconds (math -s0 $duration / 1000 % 60)
          set -l minutes (math -s0 $duration / 60000 % 60)
          set -l hours   (math -s0 $duration / 3600000 % 60)
 
          if test $duration -lt 60000;
            # Below a minute
            printf "%d.%03ds\n" $seconds $millis
          else if test $duration -lt 3600000;
            # Below a hour
            printf "%02d:%02d.%03d\n" $minutes $seconds $millis
          else
            # Everything else
            printf "%02d:%02d:%02d.%03d\n" $hours $minutes $seconds $millis
          end
	'';

	__convertsecs = ''printf "%02d:%02d:%02d\n" (math -s0 $argv[1] / 3600) (math -s0 (math $argv[1] \% 3600) / 60) (math -s0 $argv[1] \% 60)'';

	gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      };


#      plugins = [
#        {name = "theme-lambda";
#	 src = pkgs.fetchFromGitHub {
#	   owner = "hasanozgan";
#	   repo = "theme-lambda";
#	   rev = "9cf5825c31a1d09d37d87e681ac2fa1d771ef6d2";
#	   sha256 = "1aq8r27n4ifickg7my039k618d7dllknyi4g7x742hcy19zr1336";
#	 };}
#      ];
    };

    services.picom = {
      enable = true;
      activeOpacity = "1.0";
      inactiveOpacity = "0.8";
    };
  };
}
