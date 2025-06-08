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

   # ircSession is the name of the new service we'll be creating
   systemd.services.testTouch = {
      # this service is "wanted by" (see systemd man pages, or other tutorials) the system 
      # level that allows multiple users to login and interact with the machine non-graphically 
      # (see the Red Hat tutorial or Arch Linux Wiki for more information on what each target means) 
      # this is the "node" in the systemd dependency graph that will run the service
      wantedBy = [ "multi-user.target" ];
      # systemd service unit declarations involve specifying dependencies and order of execution
      # of systemd nodes; here we are saying that we want our service to start after the network has 
      # set up (as our IRC client needs to relay over the network)
      after = [ "network.target" ];
      description = "Test creating a file";
      serviceConfig = {
        # see systemd man pages for more information on the various options for "Type": "notify"
        # specifies that this is a service that waits for notification from its predecessor (declared in
        # `after=`) before starting
        Type = "notify";
        # username that systemd will look for; if it exists, it will start a service associated with that user
        User = "apple";
        # the command to execute when the service starts up 
        ExecStart = "touch ~/repos/nixos/TheServiceRan"; 
      };
   };

  programs.home-manager.enable = true;
}
