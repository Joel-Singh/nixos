set -e
sleep 3 # Wait for internet
git fetch -C /home/apple/repos/nixos/
behind_info="$(git status | grep 'is behind')"
if [ -n "$behind_info" ]; then
  git pull -C /home/apple/repos/nixos/
  sudo nixos-rebuild switch --flake ~/repos/nixos\#$CURRENT_COMPUTER
fi
