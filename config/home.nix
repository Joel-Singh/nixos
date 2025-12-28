{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.dms.homeModules.dankMaterialShell.default
  ];

  programs.home-manager.enable = true;

  home.username = "apple";
  home.homeDirectory = "/home/apple";

  home.stateVersion = "25.05"; # Do not change

  home.file = {
    ".bashrc".source = ./.bashrc;
  };

  xdg.enable = true;
  xdg.configHome = "/home/apple/repos/nixos/config/xdg-config/";

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    acpi
    libnotify
    trash-cli
    luajitPackages.luarocks
    luajit # To build nvim-treesitter
    wayclip # Clipboard access for neovim and unipicker
    gcc # Used for building new treesitters (I think)
    tree-sitter
    nodejs
    unzip
    wget
    google-chrome
    fastfetch
    brightnessctl
    file
    qutebrowser
    socat # For faster qutebrowser open
    nwg-look
    lua-language-server
    btop
    xdg-desktop-portal-gtk
    ncdu
    cloc
    hyprshot
    stylua
    markdownlint-cli
    gimp
    libqalculate
    sxiv
    jq # Used in hyprland.nix
    termdown
    signal-desktop-bin
    cheese
    pandoc
    texliveFull
    zip
    cmatrix
    audacity
    tuxpaint # beautiful program
    nwg-displays
    gnucash
    entr
    unipicker
    wl-clipboard # Different clipboard for unipicker because wayclip hangs for some reason 
    wf-recorder
    ffmpeg
    vlc
    vscode-fhs
    godot
    yt-dlp
    abaddon
    freetube
    gcr # Provides org.gnome.keyring.SystemPrompter
    gnumake
    qrencode
    typst
    pavucontrol

    arduino-cli
    arduino-language-server
    arduino-ide

    logisim-evolution
    logisim

    khal
    vdirsyncer

    gemini-cli

    wtype

    # Rust
    rustup # Comes with rust-analyzer, cargo, rustc, rustfmt

    tinymist

    dillo

    httrack

    slides

    # Dependencies for inkscape-shortcut-manager
    pdf2svg
    xclip
    rofi

    inkscape
    
    blueman

    kdePackages.kget

    gp-saml-gui # To login to denison remote

    gpclient

    wev

    nsnake

    moc # Music on console player
    xwayland-satellite
  ];


  programs.gh.enable = true;
  programs.neovim.enable = true;
  programs.ripgrep.enable = true;
  programs.fzf.enable = true;
  programs.fd.enable = true;
  programs.fd.ignores = [
    ".git/"
    ".jj/"
  ];
  programs.feh.enable = true;
  programs.bat.enable = true;
  programs.zathura.enable = true;
  programs.firefox.enable = true;
  programs.kitty.enable = true;

  programs.dankMaterialShell.enable = true;

  programs.direnv.enable = true;
  programs.direnv.silent = true;
  programs.direnv.nix-direnv.enable = true;

  programs.bacon.enable = true;
  programs.bacon.settings = {
    keybindings = {
      esc = "back";
      g = "scroll-to-top";
      shift-g = "scroll-to-bottom";
      k = "scroll-lines(-1)";
      j = "scroll-lines(1)";
      ctrl-u = "scroll-page(-1)";
      ctrl-d = "scroll-page(1)";
    };
  };

  programs.git = {
    enable = true;
    userEmail = "joelsingh788@gmail.com";
    userName = "Joel Singh";
    difftastic = {
      enable = true;
      enableAsDifftool = true;
    };
  };

  programs.lazygit = {
    enable = true;
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = "joelsingh788@gmail.com";
        name = "Joel Singh";
      };
      ui = {
        # paginate = "never";
        default-command = "log";
        editor = "nvim";
      };
      templates = {
        draft_commit_description = ''
          concat(
            coalesce(description, default_commit_description, "\n"),
            surround(
              "\nJJ: This commit contains the following changes:\n", "",
              indent("JJ:     ", diff.stat(72)),
            ),
            "\nJJ: ignore-rest\n",
            diff.git(),
          )
      '';
      };
    };
  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "text/html" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
    "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
  };
}
