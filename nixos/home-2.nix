{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rkb";
  home.homeDirectory = "/home/rkb";

  home.packages = with pkgs; [
    alacritty
    lxappearance
    brave
    coreutils-prefixed
    exa
    fd
    ffmpeg
    fzf
    ghq
    htop
    lazygit
    lf
    mc
    ncdu
    restic
    ripgrep
    rsync
    rust-analyzer
    streamlink
    stow
    tig
    tmux
    tree
    youtube-dl
  ];

  xsession.enable = true;
  xsession.windowManager.i3.enable = true;

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      polyglot
      vim-nix
      vim-gruvbox8
      vim-commentary
      vim-surround
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

  programs.emacs = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Ron";
    userEmail = "rumbletumjum@gmail.com";
  };

  programs.firefox = {
    enable = true;
    profiles = {
      rkb = {
        settings = {
          "general.smoothScroll" = false;
        };
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
