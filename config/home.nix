{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "apple";
  home.homeDirectory = "/home/apple";

  home.stateVersion = "25.05"; # Do not change

  home.file = {
    ".bashrc".source = ./.bashrc;
  };

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
    moc
    gnumake
    qrencode
    typst
    pavucontrol

    arduino-cli
    arduino-language-server
    arduino-ide

    logisim-evolution
    logisim

    openshot-qt

    evolution

    # Rust
    rustup # Comes with rust-analyzer, cargo, rustc, rustfmt

    whatsie
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
  programs.tofi.enable = true;
  programs.zathura.enable = true;
  programs.firefox.enable = true;
  programs.kitty.enable = true;

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
    settings.git.paging.externalDiffCommand = "difft --color=always";
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

  services.dunst.enable = true;

  services.gnome-keyring.enable = true;

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = import ./hyprland.nix;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/repos/nixos/config/keroppi-wallpaper.jpeg" ];
      wallpaper = [ ", ~/repos/nixos/config/keroppi-wallpaper.jpeg" ];
    };
  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "org.kde.dolphin.desktop";
  };
}
