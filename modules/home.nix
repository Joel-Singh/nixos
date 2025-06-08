{ config, pkgs, ... }:

{
  home.username = "apple";
  home.homeDirectory = "/home/apple";

  home.stateVersion = "25.05"; # Do not change

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
  wayland.windowManager.hyprland.enable = true;

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

  wayland.windowManager.hyprland.settings = import ./hyprland.nix;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/repos/nixos/modules/dotfiles/keroppi-wallpaper.jpeg" ];
      wallpaper = [ ", ~/repos/nixos/modules/dotfiles/keroppi-wallpaper.jpeg" ];
    };
  };

  home.file = {
    ".bashrc".source = dotfiles/.bashrc;
  };


  programs.home-manager.enable = true;
}
