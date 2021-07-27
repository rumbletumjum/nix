{ config, pkgs, lib, ... }:

let
  solarized8 = pkgs.vimUtils.buildVimPlugin {
    name = "vim-solarized8";
    src = pkgs.fetchFromGitHub {
      owner = "lifepillar";
      repo = "vim-solarized8";
      rev = "v1.2.0";
      sha256 = "1kb9ma1j0ijsvikzypc2dwdkrp5xy1cwcqs8gdz53n35kragfc9c";
    };
  };
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rkb";
  home.homeDirectory = "/home/rkb";

  home.packages = with pkgs; [
    aria2
    bat
    bemenu
    dmenu
    duf
    fd
    ffmpeg
    ghq
    glances
    hsetroot
    htop
    j4-dmenu-desktop
    kitty
    lf
    ncdu
    neofetch
    ripgrep
    tig
    tree
    youtube-dl

    chez racket
  ];
  
  programs.qutebrowser.enable = true;
  programs.mpv.enable = true;

  programs.git = {
    enable = true;
    userName = "rkb";
    userEmail = "rumbletumjum@gmail.com";
    aliases = {
      st = "status";
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      polyglot
      vim-nix
      vim-gruvbox8
      vim-commentary
      vim-sensible
      solarized8
      vim-surround
    ];

    extraConfig = ''
      set background=dark
      set number
      set relativenumber
      set t_Co=256
      set termguicolors
      colorscheme gruvbox8
    '';
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    terminal = "screen-256color";

    extraConfig = ''
      set -ga terminal-overrides ",xterm-256color*:Tc"
      set -g status-keys emacs
      set -g status-interval 5
      set -g status-justify centre
      set -g status-style "bg=black"
      set -g status-left "#[fg=brightwhite,bg=brightblack] #{session_name} #{window_flags} "
      set -g status-right "#[fg=brightwhite,bg=brightblack] #{host_short} "
      set -g window-status-format " #{window_index} » #{window_name} "
      set -g window-status-current-format "#[fg=white,bold,bg=brightblack] #{window_index} » #{window_name} "
      set -g renumber-windows on
    '';
  };

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = "Mod4";
      terminal = "gnome-terminal";
      menu = "${pkgs.bemenu}/bin/bemenu-run";
      defaultWorkspace = "workspace number 1";
      workspaceAutoBackAndForth = true;
      workspaceLayout = "tabbed";
      keybindings =
        let
          modifier = config.xsession.windowManager.i3.config.modifier;
          menu = config.xsession.windowManager.i3.config.menu;
        in lib.mkOptionDefault {
          "${modifier}+p" = "exec ${menu}";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
          
          "${modifier}+Shift+e" = "exec /usr/bin/gnome-session-quit --logout";
        };
      fonts = {
        names = [ "Iosevka" ];
        style = "Regular";
        size = 12.0;
      };
      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          fonts = {
            names = [ "Iosevka" ];
            style = "Regular";
            size = 10.0;
          };
        }
      ];
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
  home.stateVersion = "21.11";
}
