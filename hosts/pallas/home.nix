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
    dfc
    duf
    fd
    fdupes
    ffmpeg
    fzf
    ghq
    glances
    graphviz
    htop
    jq
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
  ];

  xdg.configFile = {
    "tmux/tmux.conf".source = ../../.dotfiles/tmux.mac/.config/tmux/tmux.conf;
  };

  programs.emacs.enable = true;

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
