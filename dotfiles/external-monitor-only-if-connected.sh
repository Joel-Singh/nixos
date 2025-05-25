connected_monitor=$(hyprctl monitors all | awk '/HDMI/')
if [ -n "$connected_monitor" ]; then
  hyprctl keyword monitor eDP-1,disable
fi
