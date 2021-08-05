{ config, pkgs, lib, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rkb";
  home.homeDirectory = "/home/rkb";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    fortune neofetch
    duf glances
    lf
    ncdu
    ncspot
  ];

  programs.bash.enable = true;
  programs.git.enable = true;

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.ubuntu_font_family;
      name = "Ubuntu Mono";
      size = 14;
    };
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      polyglot
      vim-nix
      vim-gruvbox8
    ];

    settings = {
      background = "dark";
      number = true;
      relativenumber = true;
    };

    extraConfig = ''
      set t_Co=256
      colorscheme gruvbox8
    '';
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    newSession = true;
    terminal = "screen-256color";

    extraConfig = ''
      set -g status-keys emacs
      set -g status-interval 5
      set -g renumber-windows on
    '';
  };

  services.syncthing = {
    enable = true;
  };

  xsession.enable = true;
  xsession.scriptPath = ".hm-xsession";
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      keybindings = 
        let
          modifier = config.xsession.windowManager.i3.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+p" = "exec dmenu-run";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
        };
      };
  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
