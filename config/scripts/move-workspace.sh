notify-send trying-to-switch
ws=$(hyprctl activeworkspace -j | jq .id)
if [ "$ws" -eq 1 ]; then
  hyprctl dispatch movetoworkspace 2
else
  hyprctl dispatch movetoworkspace 1
fi
