{ config, pkgs, ... }:

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
    duf
    fd
    ffmpeg
    ghq
    glances
    htop
    kitty
    lf
    ncdu
    neofetch
    ripgrep
    tree
    youtube-dl

    chez racket
  ];
  
  programs.qutebrowser.enable = true;
  programs.mpv.enable = true;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      polyglot
      vim-nix
      vim-gruvbox8
      vim-commentary
      vim-sensible
      vim-surround
    ];

    extraConfig = ''
      set background=dark
      set number
      set relativenumber
      set t_Co=256
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
    newSession = true;
    terminal = "screen-256color";

    extraConfig = ''
      set -g status-keys emacs
      set -g status-interval 5
      set -g renumber-windows on
    '';
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
