{ config, pkgs, ... }:

let
  rams = pkgs.vimUtils.buildVimPlugin {
    name = "rams.vim";
    src = pkgs.fetchFromGitHub {
      owner = "stefanvanburen";
      repo = "rams.vim";
      rev = "9917c9cf48dd0871964070a7c89702a1345f478b";
      sha256 = "1xn4isl4q3yil2hnsqka69kl3vxhvsiag0aiwifwgzkxzp0pq47c";
    };
  };
in
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
    exa
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
    tree
    tty-clock
    vis
    zoxide
    youtube-dl
    streamlink
  ];

  xdg.configFile = {
    "alacritty/alacritty.yml".source = /Users/rkb/dotlinux/alacritty/.config/alacritty/alacritty.yml;
    # "tmux/tmux.conf".source = ../../.dotfiles/tmux.mac/.config/tmux/tmux.conf;
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

  programs.emacs.enable = false;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      polyglot
      vim-nix
      vim-gruvbox8
      vim-commentary
      vim-surround
      rams
    ];

    extraConfig = ''
      set listchars=tab:»·,trail:·,nbsp:·,eol:¬,extends:>

      set expandtab
      set autoindent
      set smartindent
      set shiftwidth=4
      set softtabstop=4
      set tabstop=4

      set hidden
      set noswapfile
      set nobackup
      set undofile

      set background=light
      set number
      set relativenumber
      set nowrap
      set t_Co=256
      set termguicolors
      colorscheme rams

      autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
      autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
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
  home.stateVersion = "21.05";
}
