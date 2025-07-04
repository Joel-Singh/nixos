
active=$(hyprctl -j monitors | jq --raw-output '.[] | select(.focused==true).specialWorkspace.name | split(":") | if length > 1 then .[1] else "" end') # From https://www.reddit.com/r/hyprland/comments/1b6bf39/how_to_close_special_workspace_when_switching_to/

if [[ ${#active} -gt 0 ]]; then
  hyprctl dispatch togglespecialworkspace "$active"
else
  hyprctl dispatch workspace 2
fi

