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
    wayclip # Clipboard access for neovim
    gcc
    gnumake
    tree-sitter
    nodejs
    unzip
    wget
    google-chrome
    fastfetch
    brightnessctl
    file
    qutebrowser
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
    dig

    # Rust
    rustup # Comes with rust-analyzer, cargo, rustc, rustfmt

    # Jobbie
    dotnetCorePackages.sdk_8_0_3xx-bin
  ];

  programs.gh.enable = true;
  programs.neovim.enable = true;
  programs.ripgrep.enable = true;
  programs.fzf.enable = true;
  programs.fd.enable = true;
  programs.feh.enable = true;
  programs.bat.enable = true;
  programs.tofi.enable = true;
  programs.zathura.enable = true;
  programs.firefox.enable = true;
  programs.kitty.enable = true;
  programs.direnv.enable = true;

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

  services.dunst.enable = true;

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
