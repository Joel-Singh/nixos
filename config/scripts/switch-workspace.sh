active=$(hyprctl -j monitors | jq --raw-output '.[] | select(.focused==true).specialWorkspace.name | split(":") | if length > 1 then .[1] else "" end') # From https://www.reddit.com/r/hyprland/comments/1b6bf39/how_to_close_special_workspace_when_switching_to/

# Convert active to its length
if [[ ${#active} -gt 0 ]]; then
  hyprctl dispatch togglespecialworkspace "$active"
else
  activeWorkspace=$(hyprctl -j monitors | jq '.[0].activeWorkspace.id')
  if [[ $activeWorkspace -eq 1 ]]; then
    hyprctl dispatch workspace 2
  else
    hyprctl dispatch workspace 1
  fi
fi
