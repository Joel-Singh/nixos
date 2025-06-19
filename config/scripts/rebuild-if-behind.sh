set -e
sleep 3 # Wait for internet
cd /home/apple/repos/nixos/
git fetch
behind_info="$(git status | grep 'is behind')"
if [[ -n "$behind_info" ]]; then
  git pull
  notify-send "starting rebuilld"
  sudo nixos-rebuild switch --flake ~/repos/nixos\#$CURRENT_COMPUTER
fi
