{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rkb";
  home.homeDirectory = "/Users/rkb";

  home.packages = with pkgs; [
    abduco dvtm
    aria2
    bat
    # coreutils-prefixed
    dfc
    duf
    # exa
    fd
    fdupes
    # findutils
    ffmpeg
    # fzf
    ghq
    glances
    graphviz
    htop
    # iftop
    # jq
    kitty
    lf
    lua5_3
    mc
    ncdu
    neofetch
    restic
    ripgrep
    rsync
    stow
    tig
    tmux
    tree
    tty-clock
    vis
    # watch
    # youtube-dl
    # zenith
  ];

  xdg.configFile = {
    "tmux/tmux.conf".source = ../../.dotfiles/tmux.mac/.config/tmux/tmux.conf;
  };

  programs.emacs.enable = true;

#   programs.tmux = {
#     enable = true;
#     baseIndex = 1;
#     clock24 = true;
#     escapeTime = 0;
#     historyLimit = 10000;
#     keyMode = "vi";
#     newSession = true;
#     terminal = "screen-256color";
# 
#     extraConfig = ''
#       set -g status-keys emacs
#       set -g status-interval 5
#       set -g renumber-windows on
# 
#     '';
#   };

  # programs.vim = {
  #   enable = false;
  #   plugins = with pkgs.vimPlugins; [
  #     polyglot
  #     vim-nix
  #     vim-gruvbox8
  #     vim-commentary
  #     vim-surround
  #   ];

  #   settings = {
  #     background = "dark";
  #     number = true;
  #     relativenumber = true;
  #   };

  #   extraConfig = ''
  #     set t_Co=256
  #     colorscheme gruvbox8
  #   '';
  # };

  programs.neovim = {
    enable = false;
    vimAlias = true;
    extraConfig = builtins.readFile ./init.vim;
    plugins = with pkgs.vimPlugins; [
      polyglot
      vim-nix
      vim-gruvbox8
      vim-commentary
      vim-sensible
      vim-surround
    ];
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
