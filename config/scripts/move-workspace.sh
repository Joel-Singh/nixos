ws=$(hyprctl activeworkspace -j | jq .id)
if [ "$ws" -eq 1 ]; then
  hyprctl dispatch movetoworkspacesilent 2
else
  hyprctl dispatch movetoworkspacesilent 1
fi
