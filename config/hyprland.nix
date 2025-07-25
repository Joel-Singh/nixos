{
  workspace = [
    "1"
    "2"
  ];

  bind = [
    "$mainMod, Return, exec, $terminal"
    "$mainMod, Q, exec, /home/apple/repos/nixos/config/scripts/open_url_in_instance.sh" # Open qb faster 
    "$mainMod, D, exec, tofi-run --fuzzy-match=true --require-match=false | xargs -I {} sh -c \"{}\""
    "$mainMod, T, exec, notify-send Time \"$(date)\""
    "$mainMod, b, exec, notify-send Battery $(cat /sys/class/power_supply/BAT0/capacity || cat /sys/class/power_supply/BAT1/capacity)"
    "$mainMod, C, exec, dunstctl close"
    "$mainMod&Shift_L, C, exec, dunstctl history-pop"
    "$mainMod, P, exec, hyprshot -s -m region -o ~/screenshots"
    "$mainMod&Shift_L, H, swapwindow, l"
    "$mainMod&Shift_L, K, swapwindow, u"
    "$mainMod&Shift_L, J, swapwindow, d"
    "$mainMod&Shift_L, L, swapwindow, r"

    "$mainMod&Alt_R, H, resizeactive, -25 0"
    "$mainMod&Alt_R, K, resizeactive, 0 25"
    "$mainMod&Alt_R, J, resizeactive, 0 -25"
    "$mainMod&Alt_R, L, resizeactive, 25 0"

    "Alt_L, Tab, exec, /home/apple/repos/nixos/config/scripts/switch-workspace.sh"
    "$mainMod, bracketright, exec, /home/apple/repos/nixos/config/scripts/move-workspace.sh"
    "ALT, 4, killactive,"
    "$mainMod, V, togglefloating,"
    "$mainMod, R, exec, $menu"
    "$mainMod, Y, togglesplit, "
    "SUPER,F,fullscreen"
    "$mainMod, H, movefocus, l"
    "$mainMod, L, movefocus, r"
    "$mainMod, K, movefocus, u"
    "$mainMod, J, movefocus, d"
    "$mainMod, M, togglespecialworkspace, messages"
    "$mainMod, comma, togglespecialworkspace, logistical"
    "$mainMod SHIFT, M, movetoworkspacesilent, special:messages"
    "$mainMod SHIFT, comma, movetoworkspacesilent, special:logistical"
    "$mainMod, mouse_down, workspace, e+1"
    "$mainMod, mouse_up, workspace, e-1"
  ];

  monitor = ",preferred,auto,auto";

  "$terminal" = "kitty --working-directory \"$(cat /tmp/currentwd)\" --single-instance -o allow_remote_control=yes -o enabled_layouts=tall";
  
  exec-once = [
    "sleep 5 && qutebrowser -r start"
    "[workspace special:logistical silent] kitty -e bash -c 'sleep 10 && spotify_player'"
    "[workspace special:logistical silent] kitty -e /home/apple/repos/nixos/config/scripts/termdown-with-logging.sh"
    "sh ~/repos/nixos/config/scripts/battery-warning.sh"
    "sh ~/repos/nixos/config/scripts/external-monitor-only-if-connected.sh"
    "sh -c \"/home/apple/repos/nixos/config/scripts/pull-and-rebuild.sh || notify-send 'Failed to rebuild'\""
    "cd /home/apple/.config/qutebrowser/; sleep 10; git pull || notify-send \"Failed to pull qutebrowser repo\""
    "cd /home/apple/repos/Guiding-Principles/; sleep 10; git pull || notify-send \"Failed to pull Guiding-Principles repo\""
  ];
  
  general = {
    gaps_in = 5;
    gaps_out = 20;
    border_size = 4;
    "col.active_border" = "rgba(3ae846ee) rgba(e3e3e3ee) 60deg";
    "col.inactive_border" = "rgba(595959aa)";
    resize_on_border = false;
    allow_tearing = false;
    layout = "master";
  };
  
  
  decoration = {
    rounding = 15;
    active_opacity = 1.0;
    inactive_opacity = 0.9;
    dim_special = 0.5;
    shadow = {
        enabled = true;
        range = 9;
        render_power = 3;
        color = "rgba(1a1a1aee)";
    };
    blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
    };
  };
  
  animations = {
    enabled = "yes, please :)";
  
    bezier = [
      "easeOutQuint,0.23,1,0.32,1"
      "easeInOutCubic,0.65,0.05,0.36,1"
      "linear,0,0,1,1"
      "almostLinear,0.5,0.5,0.75,1.0"
      "quick,0.15,0,0.1,1"
    ];
  
    animation = [ 
      "global, 1, 10, default"
      "border, 1, 5.39, easeOutQuint"
      "windows, 1, 4.79, easeOutQuint"
      "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
      "windowsOut, 1, 1.49, linear, popin 87%"
      "fadeIn, 1, 1.73, almostLinear"
      "fadeOut, 1, 1.46, almostLinear"
      "fade, 1, 3.03, quick"
      "layers, 1, 3.81, easeOutQuint"
      "layersIn, 1, 4, easeOutQuint, fade"
      "layersOut, 1, 1.5, linear, fade"
      "fadeLayersIn, 1, 1.79, almostLinear"
      "fadeLayersOut, 1, 1.39, almostLinear"
      "workspaces, 1, 1.94, almostLinear, fade"
      "workspacesIn, 1, 1.21, almostLinear, fade"
      "workspacesOut, 1, 1.94, almostLinear, fade"
    ];
  };
  
  dwindle = {
    pseudotile = true;
    preserve_split = true;
  };
  
  
  master = {
    new_status = "slave";
    orientation = "left";
  };
  
  
  misc = {
    force_default_wallpaper = 0;
    disable_hyprland_logo = true;
    new_window_takes_over_fullscreen = 2;
  };

  binds = {
    workspace_back_and_forth = true;
    hide_special_on_workspace_change = true;
  };

  input = {
    kb_layout = "us";
    kb_options = "caps:swapescape";
    repeat_rate = 35;
    repeat_delay = 120;
    follow_mouse = 1;
    sensitivity = 0;
    touchpad = {
      natural_scroll = false;
    };
  };
  
  
  gestures = {
    workspace_swipe = false;
  };
  
  "$mainMod" = "SUPER";
  
  bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];
  
  bindel = [
    ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
    ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
  ];
  
  bindl = [
    ", XF86AudioNext, exec, playerctl next"
    ", XF86AudioPause, exec, playerctl play-pause"
    ", XF86AudioPlay, exec, playerctl play-pause"
    ", XF86AudioPrev, exec, playerctl previous"
  ];
  
  windowrule = [
    "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ''workspace special:messages silent, initialTitle:.*instagram\.com.*''
    ''workspace special:messages silent, initialTitle:.*voice\.google\.com.*''
    "float, class:DuckSlayer"
    "float, class:Denison Snake!"
    "center, class:Denison Snake!"
  ];
}
